; ModuleID = 'test_dump'
source_filename = "test_dump"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpfel-unknown-unknown-unknown"

@__anon_230 = internal unnamed_addr constant [13 x i8] c"Hello world!\00", align 1

; Function Attrs: minsize noredzone nounwind optsize uwtable
define dso_local i64 @entrypoint(ptr nonnull align 1 %0) #0 {
  call fastcc void @log.print__anon_237() #2
  ret i64 0
}

; Function Attrs: minsize noredzone nounwind optsize uwtable
define internal fastcc void @log.print__anon_237() unnamed_addr #0 {
  call void @sol_log_(ptr nonnull readonly align 1 @__anon_230, i64 12) #2
  ret void
}

; Function Attrs: minsize noredzone nounwind optsize uwtable
declare void @sol_log_(ptr nonnull readonly align 1, i64) #1

attributes #0 = { minsize noredzone nounwind optsize uwtable "frame-pointer"="none" "no-builtins" "target-cpu"="v3" "target-features"="+alu32,-dummy,-dwarfris" }
attributes #1 = { minsize noredzone nounwind optsize uwtable "frame-pointer"="none" "target-cpu"="v3" "target-features"="+alu32,-dummy,-dwarfris" }
attributes #2 = { nobuiltin }

!llvm.module.flags = !{}
