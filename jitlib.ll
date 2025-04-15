;;; generated from "jitlib.c"
; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @c_jit_erase(ptr noundef %0) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_allocate_buffer(i64 noundef %0) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %2 = alloca %Pos, align 8
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  store i64 %0, ptr %3, align 8
  %6 = load i64, ptr %3, align 8
  %7 = call ptr @"\01_mmap"(ptr noundef null, i64 noundef %6, i32 noundef 2, i32 noundef 4098, i32 noundef -1, i64 noundef 0)
  store ptr %7, ptr %4, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = ptrtoint ptr %8 to i64
  store i64 %9, ptr %5, align 8
  %10 = getelementptr inbounds %Pos, ptr %2, i32 0, i32 0
  %11 = load i64, ptr %5, align 8
  store i64 %11, ptr %10, align 8
  %12 = getelementptr inbounds %Pos, ptr %2, i32 0, i32 1
  store ptr null, ptr %12, align 8
  %13 = load [2 x i64], ptr %2, align 8
  ret [2 x i64] %13
}

declare ptr @"\01_mmap"(ptr noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) "frame-pointer"="non-leaf" "no-trapping-math"="true"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_free_buffer([2 x i64] %0, i64 noundef %1) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %3 = alloca %Pos, align 8
  %4 = alloca %Pos, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  store [2 x i64] %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %7 = getelementptr inbounds %Pos, ptr %4, i32 0, i32 0
  %8 = load i64, ptr %7, align 8
  %9 = inttoptr i64 %8 to ptr
  store ptr %9, ptr %6, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load i64, ptr %5, align 8
  %12 = call i32 @"\01_munmap"(ptr noundef %10, i64 noundef %11)
  %13 = getelementptr inbounds %Pos, ptr %3, i32 0, i32 0
  store i64 0, ptr %13, align 8
  %14 = getelementptr inbounds %Pos, ptr %3, i32 0, i32 1
  store ptr null, ptr %14, align 8
  %15 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %15
}

declare i32 @"\01_munmap"(ptr noundef, i64 noundef) "frame-pointer"="non-leaf" "no-trapping-math"="true"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_make_writable([2 x i64] %0, i64 noundef %1) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %3 = alloca %Pos, align 8
  %4 = alloca %Pos, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  store [2 x i64] %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %7 = getelementptr inbounds %Pos, ptr %4, i32 0, i32 0
  %8 = load i64, ptr %7, align 8
  %9 = inttoptr i64 %8 to ptr
  store ptr %9, ptr %6, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load i64, ptr %5, align 8
  %12 = call i32 @"\01_mprotect"(ptr noundef %10, i64 noundef %11, i32 noundef 3)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 %4, i64 16, i1 false)
  %13 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %13
}

declare i32 @"\01_mprotect"(ptr noundef, i64 noundef, i32 noundef) "frame-pointer"="non-leaf" "no-trapping-math"="true"

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) nocallback nofree nounwind willreturn memory(argmem: readwrite)

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_make_executable([2 x i64] %0, i64 noundef %1) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %3 = alloca %Pos, align 8
  %4 = alloca %Pos, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  store [2 x i64] %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %7 = getelementptr inbounds %Pos, ptr %4, i32 0, i32 0
  %8 = load i64, ptr %7, align 8
  %9 = inttoptr i64 %8 to ptr
  store ptr %9, ptr %6, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load i64, ptr %5, align 8
  %12 = call i32 @"\01_mprotect"(ptr noundef %10, i64 noundef %11, i32 noundef 4)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 %4, i64 16, i1 false)
  %13 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %13
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_write([2 x i64] %0, i64 noundef %1, i8 noundef zeroext %2) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %4 = alloca %Pos, align 8
  %5 = alloca %Pos, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8, align 1
  %8 = alloca ptr, align 8
  store [2 x i64] %0, ptr %5, align 8
  store i64 %1, ptr %6, align 8
  store i8 %2, ptr %7, align 1
  %9 = getelementptr inbounds %Pos, ptr %5, i32 0, i32 0
  %10 = load i64, ptr %9, align 8
  %11 = inttoptr i64 %10 to ptr
  store ptr %11, ptr %8, align 8
  %12 = load i8, ptr %7, align 1
  %13 = load ptr, ptr %8, align 8
  %14 = load i64, ptr %6, align 8
  %15 = getelementptr inbounds i8, ptr %13, i64 %14
  store i8 %12, ptr %15, align 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 %5, i64 16, i1 false)
  %16 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %16
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i64 @c_jit_callI_I([2 x i64] %0, i64 noundef %1, i64 noundef %2) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %4 = alloca %Pos, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store [2 x i64] %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %9 = getelementptr inbounds %Pos, ptr %4, i32 0, i32 0
  %10 = load i64, ptr %9, align 8
  %11 = inttoptr i64 %10 to ptr
  store ptr %11, ptr %7, align 8
  %12 = load ptr, ptr %7, align 8
  %13 = load i64, ptr %5, align 8
  %14 = getelementptr inbounds i8, ptr %12, i64 %13
  store ptr %14, ptr %8, align 8
  %15 = load ptr, ptr %8, align 8
  %16 = load i64, ptr %6, align 8
  %17 = call i64 %15(i64 noundef %16)
  ret i64 %17
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i64 @c_jit_callI_PI([2 x i64] %0, i64 noundef %1, [2 x i64] %2, i64 noundef %3) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %5 = alloca %Pos, align 8
  %6 = alloca %Pos, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  store [2 x i64] %0, ptr %5, align 8
  store [2 x i64] %2, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  store i64 %3, ptr %8, align 8
  %11 = getelementptr inbounds %Pos, ptr %5, i32 0, i32 0
  %12 = load i64, ptr %11, align 8
  %13 = inttoptr i64 %12 to ptr
  store ptr %13, ptr %9, align 8
  %14 = load ptr, ptr %9, align 8
  %15 = load i64, ptr %7, align 8
  %16 = getelementptr inbounds i8, ptr %14, i64 %15
  store ptr %16, ptr %10, align 8
  %17 = load ptr, ptr %10, align 8
  %18 = load i64, ptr %8, align 8
  %19 = load [2 x i64], ptr %6, align 8
  %20 = call i64 %17([2 x i64] %19, i64 noundef %18)
  ret i64 %20
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_callP_P([2 x i64] %0, i64 noundef %1, [2 x i64] %2) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %4 = alloca %Pos, align 8
  %5 = alloca %Pos, align 8
  %6 = alloca %Pos, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store [2 x i64] %0, ptr %5, align 8
  store [2 x i64] %2, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  %10 = getelementptr inbounds %Pos, ptr %5, i32 0, i32 0
  %11 = load i64, ptr %10, align 8
  %12 = inttoptr i64 %11 to ptr
  store ptr %12, ptr %8, align 8
  %13 = load ptr, ptr %8, align 8
  %14 = load i64, ptr %7, align 8
  %15 = getelementptr inbounds i8, ptr %13, i64 %14
  store ptr %15, ptr %9, align 8
  %16 = load ptr, ptr %9, align 8
  %17 = load [2 x i64], ptr %6, align 8
  %18 = call [2 x i64] %16([2 x i64] %17)
  store [2 x i64] %18, ptr %4, align 8
  %19 = load [2 x i64], ptr %4, align 8
  ret [2 x i64] %19
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define [2 x i64] @c_jit_callP_PP([2 x i64] %0, i64 noundef %1, [2 x i64] %2, [2 x i64] %3) noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" {
  %5 = alloca %Pos, align 8
  %6 = alloca %Pos, align 8
  %7 = alloca %Pos, align 8
  %8 = alloca %Pos, align 8
  %9 = alloca i64, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store [2 x i64] %0, ptr %6, align 8
  store [2 x i64] %2, ptr %7, align 8
  store [2 x i64] %3, ptr %8, align 8
  store i64 %1, ptr %9, align 8
  %12 = getelementptr inbounds %Pos, ptr %6, i32 0, i32 0
  %13 = load i64, ptr %12, align 8
  %14 = inttoptr i64 %13 to ptr
  store ptr %14, ptr %10, align 8
  %15 = load ptr, ptr %10, align 8
  %16 = load i64, ptr %9, align 8
  %17 = getelementptr inbounds i8, ptr %15, i64 %16
  store ptr %17, ptr %11, align 8
  %18 = load ptr, ptr %11, align 8
  %19 = load [2 x i64], ptr %7, align 8
  %20 = load [2 x i64], ptr %8, align 8
  %21 = call [2 x i64] %18([2 x i64] %19, [2 x i64] %20)
  store [2 x i64] %21, ptr %5, align 8
  %22 = load [2 x i64], ptr %5, align 8
  ret [2 x i64] %22
}

