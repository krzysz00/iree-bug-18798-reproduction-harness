define amdgpu_kernel void @test_dispatch_0_conv_2d_ngchw_gfchw_q_1x2x1x1x1x8x3x3_i8xi8xi32xi32xi32(ptr addrspace(1) noalias readonly align 16 %.0, ptr addrspace(1) noalias readonly align 16 %.1, ptr addrspace(1) noalias align 16 %.2) local_unnamed_addr #0 !reqd_work_group_size !0 {
.entry:
  %.4 = tail call i32 @llvm.amdgcn.workitem.id.x()
  %.5 = sext i32 %.4 to i64
  %.22 = icmp slt i64 %.5, 2
  br i1 %.22, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.entry, %.110
  %.23 = phi i64 [ %.111, %.110 ], [ %.5, %.entry ]
  %.24 = getelementptr i32, ptr addrspace(1) %.2, i64 %.23
  %.25 = mul nsw i64 %.23, 72
  br label %.preheader2

.preheader2:                                      ; preds = %.lr.ph, %.preheader2
  %.26 = phi i64 [ 0, %.lr.ph ], [ %.109, %.preheader2 ]
  %.lcssa4.lcssa67 = phi i32 [ 0, %.lr.ph ], [ %.108, %.preheader2 ]
  %.27 = mul nuw nsw i64 %.26, 9
  %.28 = add nsw i64 %.27, %.25
  %.29 = getelementptr i8, ptr addrspace(1) %.0, i64 %.28
  %.30 = load i8, ptr addrspace(1) %.29, align 1
  %.31 = getelementptr i8, ptr addrspace(1) %.1, i64 %.28
  %.32 = load i8, ptr addrspace(1) %.31, align 1
  %.33 = sext i8 %.30 to i32
  %.34 = sext i8 %.32 to i32
  %.35 = mul nsw i32 %.34, %.33
  %.36 = add i32 %.35, %.lcssa4.lcssa67
  %.37 = add nsw i64 %.28, 1
  %.38 = getelementptr i8, ptr addrspace(1) %.0, i64 %.37
  %.39 = load i8, ptr addrspace(1) %.38, align 1
  %.40 = getelementptr i8, ptr addrspace(1) %.1, i64 %.37
  %.41 = load i8, ptr addrspace(1) %.40, align 1
  %.42 = sext i8 %.39 to i32
  %.43 = sext i8 %.41 to i32
  %.44 = mul nsw i32 %.43, %.42
  %.45 = add i32 %.44, %.36
  %.46 = add nsw i64 %.28, 2
  %.47 = getelementptr i8, ptr addrspace(1) %.0, i64 %.46
  %.48 = load i8, ptr addrspace(1) %.47, align 1
  %.49 = getelementptr i8, ptr addrspace(1) %.1, i64 %.46
  %.50 = load i8, ptr addrspace(1) %.49, align 1
  %.51 = sext i8 %.48 to i32
  %.52 = sext i8 %.50 to i32
  %.53 = mul nsw i32 %.52, %.51
  %.54 = add i32 %.53, %.45
  %.55 = add nsw i64 %.28, 3
  %.56 = getelementptr i8, ptr addrspace(1) %.0, i64 %.55
  %.57 = load i8, ptr addrspace(1) %.56, align 1
  %.58 = getelementptr i8, ptr addrspace(1) %.1, i64 %.55
  %.59 = load i8, ptr addrspace(1) %.58, align 1
  %.60 = sext i8 %.57 to i32
  %.61 = sext i8 %.59 to i32
  %.62 = mul nsw i32 %.61, %.60
  %.63 = add i32 %.62, %.54
  %.64 = add nsw i64 %.28, 4
  %.65 = getelementptr i8, ptr addrspace(1) %.0, i64 %.64
  %.66 = load i8, ptr addrspace(1) %.65, align 1
  %.67 = getelementptr i8, ptr addrspace(1) %.1, i64 %.64
  %.68 = load i8, ptr addrspace(1) %.67, align 1
  %.69 = sext i8 %.66 to i32
  %.70 = sext i8 %.68 to i32
  %.71 = mul nsw i32 %.70, %.69
  %.72 = add i32 %.71, %.63
  %.73 = add nsw i64 %.28, 5
  %.74 = getelementptr i8, ptr addrspace(1) %.0, i64 %.73
  %.75 = load i8, ptr addrspace(1) %.74, align 1
  %.76 = getelementptr i8, ptr addrspace(1) %.1, i64 %.73
  %.77 = load i8, ptr addrspace(1) %.76, align 1
  %.78 = sext i8 %.75 to i32
  %.79 = sext i8 %.77 to i32
  %.80 = mul nsw i32 %.79, %.78
  %.81 = add i32 %.80, %.72
  %.82 = add nsw i64 %.28, 6
  %.83 = getelementptr i8, ptr addrspace(1) %.0, i64 %.82
  %.84 = load i8, ptr addrspace(1) %.83, align 1
  %.85 = getelementptr i8, ptr addrspace(1) %.1, i64 %.82
  %.86 = load i8, ptr addrspace(1) %.85, align 1
  %.87 = sext i8 %.84 to i32
  %.88 = sext i8 %.86 to i32
  %.89 = mul nsw i32 %.88, %.87
  %.90 = add i32 %.89, %.81
  %.91 = add nsw i64 %.28, 7
  %.92 = getelementptr i8, ptr addrspace(1) %.0, i64 %.91
  %.93 = load i8, ptr addrspace(1) %.92, align 1
  %.94 = getelementptr i8, ptr addrspace(1) %.1, i64 %.91
  %.95 = load i8, ptr addrspace(1) %.94, align 1
  %.96 = sext i8 %.93 to i32
  %.97 = sext i8 %.95 to i32
  %.98 = mul nsw i32 %.97, %.96
  %.99 = add i32 %.98, %.90
  %.100 = add nsw i64 %.28, 8
  %.101 = getelementptr i8, ptr addrspace(1) %.0, i64 %.100
  %.102 = load i8, ptr addrspace(1) %.101, align 1
  %.103 = getelementptr i8, ptr addrspace(1) %.1, i64 %.100
  %.104 = load i8, ptr addrspace(1) %.103, align 1
  %.105 = sext i8 %.102 to i32
  %.106 = sext i8 %.104 to i32
  %.107 = mul nsw i32 %.106, %.105
  %.108 = add i32 %.107, %.99
  %.109 = add nuw nsw i64 %.26, 1
  %exitcond.not = icmp eq i64 %.109, 8
  br i1 %exitcond.not, label %.110, label %.preheader2

.110:                                              ; preds = %.preheader2
  store i32 %.108, ptr addrspace(1) %.24, align 4
  %.111 = add nsw i64 %.23, 32
  %.112 = icmp slt i64 %.23, -30
  br i1 %.112, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.110, %.3
  ret void
}

; Function Attrs: alwaysinline mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef i32 @llvm.amdgcn.workitem.id.x() #1

; Function Attrs: alwaysinline mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef i32 @llvm.amdgcn.workitem.id.y() #1

; Function Attrs: alwaysinline mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef i32 @llvm.amdgcn.workitem.id.z() #1

; Function Attrs: alwaysinline mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #2

attributes #0 = { alwaysinline nofree norecurse nosync nounwind memory(argmem: readwrite, inaccessiblemem: write) "amdgpu-flat-work-group-size"="32,32" "amdgpu-no-agpr" "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "uniform-work-group-size"="true" }
attributes #1 = { alwaysinline mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { alwaysinline mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!0 = !{i32 32, i32 1, i32 1}
