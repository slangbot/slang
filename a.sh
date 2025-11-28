#!/usr/bin/env bash

# Script to wrap pass functions with SLANG_PASS macro
# Usage: ./wrap_passes.sh <filename>

FILE="${1:-slang-ir-link.cpp}"

if [ ! -f "$FILE" ]; then
  echo "Error: File '$FILE' not found"
  exit 1
fi

# Create backup
cp "$FILE" "$FILE.bak"

# Apply replacements using sed
# Note: Using | as delimiter to avoid issues with special characters

# Simple passes with no extra arguments
sed -i 's/resolveVaryingInputRef(irModule);/SLANG_PASS(resolveVaryingInputRef);/g' "$FILE"
sed -i 's/performForceInlining(irModule);/SLANG_PASS(performForceInlining);/g' "$FILE"
sed -i 's/resolveTextureFormat(irModule);/SLANG_PASS(resolveTextureFormat);/g' "$FILE"
sed -i 's/legalizeNonStructParameterToStructForHLSL(irModule);/SLANG_PASS(legalizeNonStructParameterToStructForHLSL);/g' "$FILE"
sed -i 's/legalizeConstantBufferLoadForGLSL(irModule);/SLANG_PASS(legalizeConstantBufferLoadForGLSL);/g' "$FILE"
sed -i 's/legalizeDispatchMeshPayloadForGLSL(irModule);/SLANG_PASS(legalizeDispatchMeshPayloadForGLSL);/g' "$FILE"
sed -i 's/undoParameterCopy(irModule);/SLANG_PASS(undoParameterCopy);/g' "$FILE"
sed -i 's/convertEntryPointPtrParamsToRawPtrs(irModule);/SLANG_PASS(convertEntryPointPtrParamsToRawPtrs);/g' "$FILE"
sed -i 's/stripLegalizationOnlyInstructions(irModule);/SLANG_PASS(stripLegalizationOnlyInstructions);/g' "$FILE"
sed -i 's/removeRawDefaultConstructors(irModule);/SLANG_PASS(removeRawDefaultConstructors);/g' "$FILE"
sed -i 's/cleanUpVoidType(irModule);/SLANG_PASS(cleanUpVoidType);/g' "$FILE"
sed -i 's/legalizeMeshOutputTypes(irModule);/SLANG_PASS(legalizeMeshOutputTypes);/g' "$FILE"
sed -i 's/legalizeArrayReturnType(irModule);/SLANG_PASS(legalizeArrayReturnType);/g' "$FILE"
sed -i 's/legalizeUniformBufferLoad(irModule);/SLANG_PASS(legalizeUniformBufferLoad);/g' "$FILE"
sed -i 's/invertYOfPositionOutput(irModule);/SLANG_PASS(invertYOfPositionOutput);/g' "$FILE"
sed -i 's/rcpWOfPositionInput(irModule);/SLANG_PASS(rcpWOfPositionInput);/g' "$FILE"
sed -i 's/performIntrinsicFunctionInlining(irModule);/SLANG_PASS(performIntrinsicFunctionInlining);/g' "$FILE"
sed -i 's/eliminateMultiLevelBreak(irModule);/SLANG_PASS(eliminateMultiLevelBreak);/g' "$FILE"
sed -i 's/applyGLSLLiveness(irModule);/SLANG_PASS(applyGLSLLiveness);/g' "$FILE"

# Passes with sink argument
sed -i 's/lowerCooperativeVectors(irModule, sink);/SLANG_PASS(lowerCooperativeVectors, sink);/g' "$FILE"
sed -i 's/legalizeEmptyArray(irModule, sink);/SLANG_PASS(legalizeEmptyArray, sink);/g' "$FILE"
sed -i 's/legalizeVectorTypes(irModule, sink);/SLANG_PASS(legalizeVectorTypes, sink);/g' "$FILE"
sed -i 's/legalizeIRForMetal(irModule, sink);/SLANG_PASS(legalizeIRForMetal, sink);/g' "$FILE"
sed -i 's/legalizeIRForWGSL(irModule, sink);/SLANG_PASS(legalizeIRForWGSL, sink);/g' "$FILE"
sed -i 's/lowerEnumType(irModule, sink);/SLANG_PASS(lowerEnumType, sink);/g' "$FILE"

# Passes with codeGenContext->getSink()
sed -i 's/synthesizeActiveMask(irModule, codeGenContext->getSink());/SLANG_PASS(synthesizeActiveMask, codeGenContext->getSink());/g' "$FILE"
sed -i 's/legalizeEntryPointVaryingParamsForCPU(irModule, codeGenContext->getSink());/SLANG_PASS(legalizeEntryPointVaryingParamsForCPU, codeGenContext->getSink());/g' "$FILE"
sed -i 's/legalizeEntryPointVaryingParamsForCUDA(irModule, codeGenContext->getSink());/SLANG_PASS(legalizeEntryPointVaryingParamsForCUDA, codeGenContext->getSink());/g' "$FILE"
sed -i 's/transformParamsToConstRef(irModule, codeGenContext->getSink());/SLANG_PASS(transformParamsToConstRef, codeGenContext->getSink());/g' "$FILE"

# Passes with targetProgram
sed -i 's/lowerLValueCast(targetProgram, irModule);/SLANG_PASS(lowerLValueCast, targetProgram);/g' "$FILE"
sed -i 's/specializeMatrixLayout(targetProgram, irModule);/SLANG_PASS(specializeMatrixLayout, targetProgram);/g' "$FILE"
sed -i 's/finalizeAutoDiffPass(targetProgram, irModule);/SLANG_PASS(finalizeAutoDiffPass, targetProgram);/g' "$FILE"
sed -i 's/performGLSLResourceReturnFunctionInlining(targetProgram, irModule);/SLANG_PASS(performGLSLResourceReturnFunctionInlining, targetProgram);/g' "$FILE"
sed -i 's/lowerImmutableBufferLoadForCUDA(targetProgram, irModule);/SLANG_PASS(lowerImmutableBufferLoadForCUDA, targetProgram);/g' "$FILE"

# Passes with targetProgram and sink
sed -i 's/checkAutodiffPatterns(targetProgram, irModule, sink);/SLANG_PASS(checkAutodiffPatterns, targetProgram, sink);/g' "$FILE"
sed -i 's/lowerGenerics(targetProgram, irModule, sink);/SLANG_PASS(lowerGenerics, targetProgram, sink);/g' "$FILE"
sed -i 's/cleanupGenerics(targetProgram, irModule, sink);/SLANG_PASS(cleanupGenerics, targetProgram, sink);/g' "$FILE"
sed -i 's/lowerAppendConsumeStructuredBuffers(targetProgram, irModule, sink);/SLANG_PASS(lowerAppendConsumeStructuredBuffers, targetProgram, sink);/g' "$FILE"
sed -i 's/legalizeExistentialTypeLayout(targetProgram, irModule, sink);/SLANG_PASS(legalizeExistentialTypeLayout, targetProgram, sink);/g' "$FILE"
sed -i 's/legalizeResourceTypes(targetProgram, irModule, sink);/SLANG_PASS(legalizeResourceTypes, targetProgram, sink);/g' "$FILE"
sed -i 's/legalizeEmptyTypes(targetProgram, irModule, sink);/SLANG_PASS(legalizeEmptyTypes, targetProgram, sink);/g' "$FILE"
sed -i 's/legalizeMatrixTypes(targetProgram, irModule, sink);/SLANG_PASS(legalizeMatrixTypes, targetProgram, sink);/g' "$FILE"
sed -i 's/lowerDynamicResourceHeap(targetProgram, irModule, sink);/SLANG_PASS(lowerDynamicResourceHeap, targetProgram, sink);/g' "$FILE"
sed -i 's/lowerBitCast(targetProgram, irModule, sink);/SLANG_PASS(lowerBitCast, targetProgram, sink);/g' "$FILE"
sed -i 's/replaceLocationIntrinsicsWithRaytracingObject(targetProgram, irModule, sink);/SLANG_PASS(replaceLocationIntrinsicsWithRaytracingObject, targetProgram, sink);/g' "$FILE"

# Passes with codeGenContext
sed -i 's/translateGlobalVaryingVar(codeGenContext, irModule);/SLANG_PASS(translateGlobalVaryingVar, codeGenContext);/g' "$FILE"
sed -i 's/specializeResourceUsage(codeGenContext, irModule);/SLANG_PASS(specializeResourceUsage, codeGenContext);/g' "$FILE"
sed -i 's/specializeFuncsForBufferLoadArgs(codeGenContext, irModule);/SLANG_PASS(specializeFuncsForBufferLoadArgs, codeGenContext);/g' "$FILE"
sed -i 's/deferBufferLoad(codeGenContext, irModule);/SLANG_PASS(deferBufferLoad, codeGenContext);/g' "$FILE"
sed -i 's/specializeArrayParameters(codeGenContext, irModule);/SLANG_PASS(specializeArrayParameters, codeGenContext);/g' "$FILE"
sed -i 's/legalizeDynamicResourcesForGLSL(codeGenContext, irModule);/SLANG_PASS(legalizeDynamicResourcesForGLSL, codeGenContext);/g' "$FILE"
sed -i 's/legalizeModesOfNonCopyableOpaqueTypedParamsForGLSL(codeGenContext, irModule);/SLANG_PASS(legalizeModesOfNonCopyableOpaqueTypedParamsForGLSL, codeGenContext);/g' "$FILE"

# Passes with codeGenContext and sink
sed -i 's/lowerCombinedTextureSamplers(codeGenContext, irModule, sink);/SLANG_PASS(lowerCombinedTextureSamplers, codeGenContext, sink);/g' "$FILE"

# Passes with target
sed -i 's/removeAvailableInDownstreamModuleDecorations(target, irModule);/SLANG_PASS(removeAvailableInDownstreamModuleDecorations, target);/g' "$FILE"
sed -i 's/introduceExplicitGlobalContext(irModule, target);/SLANG_PASS(introduceExplicitGlobalContext, target);/g' "$FILE"
sed -i 's/unexportNonEmbeddableIR(target, irModule);/SLANG_PASS(unexportNonEmbeddableIR, target);/g' "$FILE"

# Passes with targetRequest
sed -i 's/legalizeImageSubscript(targetRequest, irModule, sink);/SLANG_PASS(legalizeImageSubscript, targetRequest, sink);/g' "$FILE"

# Passes with targetProgram and other args
sed -i 's/moveGlobalVarInitializationToEntryPoints(irModule, targetProgram);/SLANG_PASS(moveGlobalVarInitializationToEntryPoints, targetProgram);/g' "$FILE"

# Passes with specific enum/mode arguments
sed -i 's/floatNonUniformResourceIndex(irModule, NonUniformResourceIndexFloatMode::Textual);/SLANG_PASS(floatNonUniformResourceIndex, NonUniformResourceIndexFloatMode::Textual);/g' "$FILE"

# Passes with codeGenContext->getTargetProgram()
sed -i 's/generateDllImportFuncs(codeGenContext->getTargetProgram(), irModule, sink);/SLANG_PASS(generateDllImportFuncs, codeGenContext->getTargetProgram(), sink);/g' "$FILE"

# Passes with metadata
sed -i 's/collectMetadata(irModule, \*metadata);/SLANG_PASS(collectMetadata, *metadata);/g' "$FILE"

# LivenessUtil static methods
sed -i 's/LivenessUtil::addVariableRangeStarts(irModule, livenessMode);/SLANG_PASS(LivenessUtil::addVariableRangeStarts, livenessMode);/g' "$FILE"
sed -i 's/LivenessUtil::addRangeEnds(irModule, livenessMode);/SLANG_PASS(LivenessUtil::addRangeEnds, livenessMode);/g' "$FILE"

# Validation/checking functions (Section 4)
sed -i 's/checkForRecursiveFunctions(codeGenContext->getTargetReq(), irModule, sink);/SLANG_PASS(checkForRecursiveFunctions, codeGenContext->getTargetReq(), sink);/g' "$FILE"
sed -i 's/checkForInvalidShaderParameterType(targetRequest, irModule, sink);/SLANG_PASS(checkForInvalidShaderParameterType, targetRequest, sink);/g' "$FILE"
sed -i 's/validateVectorsAndMatrices(irModule, sink, targetRequest);/SLANG_PASS(validateVectorsAndMatrices, sink, targetRequest);/g' "$FILE"
sed -i 's/checkUnsupportedInst(codeGenContext->getTargetReq(), irModule, sink);/SLANG_PASS(checkUnsupportedInst, codeGenContext->getTargetReq(), sink);/g' "$FILE"

# specializeAddressSpace variants
sed -i 's/specializeAddressSpaceForMetal(irModule);/SLANG_PASS(specializeAddressSpaceForMetal);/g' "$FILE"
sed -i 's/specializeAddressSpaceForWGSL(irModule);/SLANG_PASS(specializeAddressSpaceForWGSL);/g' "$FILE"

echo "Done! Backup saved as $FILE.bak"
echo ""
echo "The following passes could NOT be wrapped (irModule is not first parameter or has special handling):"
echo "  - simplifyIR(targetProgram, irModule, ...)"
echo "  - simplifyNonSSAIR(targetProgram, irModule, ...)"
echo "  - specializeModule(targetProgram, irModule, ...)"
echo "  - applySparseConditionalConstantPropagation(irModule, sink)"
echo "  - eliminateDeadCode(irModule, deadCodeEliminationOptions)"
echo "  - unrollLoopsInModule(targetProgram, irModule, sink)"
echo "  - specializeHigherOrderParameters(codeGenContext, irModule) - returns bool"
echo "  - processAutodiffCalls(targetProgram, irModule, sink) - returns bool"
echo "  - legalizeByteAddressBufferOps(session, targetProgram, irModule, sink, options)"
echo "  - legalizeEntryPointsForGLSL(session, irModule, irEntryPoints, codeGenContext, tracker)"
echo "  - specializeAddressSpace(irModule, &addrSpaceAssigner)"
echo "  - lowerBufferElementTypeToStorageType(targetProgram, irModule, options)"
echo "  - eliminatePhis(livenessMode, irModule, options)"
echo "  - applyVariableScopeCorrection(irModule, targetRequest)"
echo "  - calcRequiredLoweringPassSet(..., irModule->getModuleInst())"
echo "  - checkStaticAssert(irModule->getModuleInst(), sink)"
echo "  - validateAtomicOperations(..., irModule->getModuleInst())"
echo "  - legalizeLogicalAndOr(irModule->getModuleInst())"
echo "  - validateStructuredBufferResourceTypes(irModule, sink, targetRequest) - return value checked"
echo "  - performTypeInlining(irModule, targetProgram, sink) - SLANG_RETURN_ON_FAIL"
echo "  - checkGetStringHashInsts(irModule, sink) - SLANG_RETURN_ON_FAIL"
echo "  - inferAnyValueSizeWhereNecessary(targetProgram, irModule)"
echo "  - lowerReinterpret(targetProgram, irModule, sink)"
echo "  - reportCheckpointIntermediates(codeGenContext, sink, irModule)"
