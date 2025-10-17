; ModuleID = 'test_dump'
source_filename = "test_dump"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpfel-unknown-unknown-unknown"

; Function Attrs: minsize noredzone nounwind optsize uwtable
define dso_local noundef i64 @entrypoint(ptr nocapture nonnull readnone align 1 %0) local_unnamed_addr #0 {
  tail call fastcc void @sol_log_() #2
  ret i64 0
}

; Function Attrs: minsize noredzone nounwind optsize uwtable
declare internal fastcc void @sol_log_() unnamed_addr #1

attributes #0 = { minsize noredzone nounwind optsize uwtable "frame-pointer"="none" "no-builtins" "target-cpu"="v3" "target-features"="+alu32,-dummy,-dwarfris" }
attributes #1 = { minsize noredzone nounwind optsize uwtable "frame-pointer"="none" "target-cpu"="v3" "target-features"="+alu32,-dummy,-dwarfris" }
attributes #2 = { nobuiltin }

!llvm.module.flags = !{}
