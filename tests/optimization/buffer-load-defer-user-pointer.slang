//TEST:SIMPLE(filecheck=SPV): -target spirv -O0
//TEST:SIMPLE(filecheck=CUDA): -target cuda -entry compute_main -stage compute
//TEST:SIMPLE(filecheck=PTX): -target ptx -entry compute_main -stage compute

// Check that we can specialize buffer loads through user pointers, and
// do not load big struct elements into registers unnecessarily.

struct Bottom
{
    float bigArray[1024];
    float bottomGetValue(int index) { return bigArray[index]; }
}

struct Middle
{
    Bottom bottom;
    float middleGetValue(int index) { return bottom.bottomGetValue(index); }
}

struct Top
{
    StructuredBuffer<Middle*>.Handle middle;

    // Calling `middleGetValue` on `middle[0]` should not causing the entire `Middle`
    // struct to be loaded into registers. Instead, we should be able to specialize
    // `middleGetValue` to take a `Middle*` and recursively specialize `bottomGetValue`
    // to only load the `Bottom.bigArray[index]` element.
    float topGetValue(int index) { return middle[0].middleGetValue(index); }
}

struct Root
{
    Top top;
}

ConstantBuffer<Root> cb;

RWStructuredBuffer<float> outputBuffer;

// Check that the generated CUDA code contains a `middleGetValue` function that takes in `Middle*`,
// and called from `topGetValue` with `middle[0]` as argument, without loading the entire `Middle` struct.
//
// CUDA-DAG: __device__ float Middle_middleGetValue{{.*}}(Middle{{.*}} * {{.*}}, int {{.*}})
// CUDA-DAG: __device__ float Top_topGetValue{{.*}}(Top{{.*}} * {{.*}}, int {{.*}})
// CUDA: float {{.*}} = Middle_middleGetValue{{.*}}(*(&(this{{.*}}->middle{{.*}})[int(0)]), {{.*}});
// PTX: compute_main

[shader("compute")]
[numthreads(1, 1, 1)]
void compute_main(uint3 tid: SV_DispatchThreadID)
{
    outputBuffer[0] = cb.top.topGetValue(0);
}
