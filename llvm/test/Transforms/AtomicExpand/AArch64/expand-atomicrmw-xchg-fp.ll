; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -O1 -S -mtriple=aarch64-- -atomic-expand %s | FileCheck %s
; RUN: opt -O1 -S -mtriple=aarch64-- -mattr=+outline-atomics -atomic-expand %s | FileCheck %s --check-prefix=OUTLINE-ATOMICS

define void @atomic_swap_f16(half* %ptr, half %val) nounwind {
; CHECK-LABEL: @atomic_swap_f16(
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.ldaxr.p0f16(half* [[PTR:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i16
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i16 [[TMP2]] to half
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast half [[VAL:%.*]] to i16
; CHECK-NEXT:    [[TMP5:%.*]] = zext i16 [[TMP4]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.aarch64.stxr.p0f16(i64 [[TMP5]], half* [[PTR]])
; CHECK-NEXT:    [[TRYAGAIN:%.*]] = icmp ne i32 [[TMP6]], 0
; CHECK-NEXT:    br i1 [[TRYAGAIN]], label [[ATOMICRMW_START]], label [[ATOMICRMW_END:%.*]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret void
;
; OUTLINE-ATOMICS-LABEL: @atomic_swap_f16(
; OUTLINE-ATOMICS-NEXT:    [[T1:%.*]] = atomicrmw xchg half* [[PTR:%.*]], half [[VAL:%.*]] acquire
; OUTLINE-ATOMICS-NEXT:    ret void
;
  %t1 = atomicrmw xchg half* %ptr, half %val acquire
  ret void
}

define void @atomic_swap_f32(float* %ptr, float %val) nounwind {
; CHECK-LABEL: @atomic_swap_f32(
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.ldaxr.p0f32(float* [[PTR:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i32 [[TMP2]] to float
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast float [[VAL:%.*]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.aarch64.stxr.p0f32(i64 [[TMP5]], float* [[PTR]])
; CHECK-NEXT:    [[TRYAGAIN:%.*]] = icmp ne i32 [[TMP6]], 0
; CHECK-NEXT:    br i1 [[TRYAGAIN]], label [[ATOMICRMW_START]], label [[ATOMICRMW_END:%.*]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret void
;
; OUTLINE-ATOMICS-LABEL: @atomic_swap_f32(
; OUTLINE-ATOMICS-NEXT:    [[T1:%.*]] = atomicrmw xchg float* [[PTR:%.*]], float [[VAL:%.*]] acquire
; OUTLINE-ATOMICS-NEXT:    ret void
;
  %t1 = atomicrmw xchg float* %ptr, float %val acquire
  ret void
}

define void @atomic_swap_f64(double* %ptr, double %val) nounwind {
; CHECK-LABEL: @atomic_swap_f64(
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.aarch64.ldaxr.p0f64(double* [[PTR:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i64 [[TMP1]] to double
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double [[VAL:%.*]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.aarch64.stxr.p0f64(i64 [[TMP3]], double* [[PTR]])
; CHECK-NEXT:    [[TRYAGAIN:%.*]] = icmp ne i32 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TRYAGAIN]], label [[ATOMICRMW_START]], label [[ATOMICRMW_END:%.*]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret void
;
; OUTLINE-ATOMICS-LABEL: @atomic_swap_f64(
; OUTLINE-ATOMICS-NEXT:    [[T1:%.*]] = atomicrmw xchg double* [[PTR:%.*]], double [[VAL:%.*]] acquire
; OUTLINE-ATOMICS-NEXT:    ret void
;
  %t1 = atomicrmw xchg double* %ptr, double %val acquire
  ret void
}