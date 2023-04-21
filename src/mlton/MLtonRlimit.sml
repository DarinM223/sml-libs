signature MLTON_RLIMIT = sig
  structure RLim : sig
    type t
    val castFromSysWord : SysWord.word -> t
    val castToSysWord : t -> SysWord.word
  end
  val infinity : RLim.t
  type t
  val coreFileSize : t (* CORE max core file size *)
  val cpuTime : t (* CPU CPU time in seconds *)
  val dataSize : t (* DATA max data size *)
  val fileSize : t (* FSIZE Maximum filesize *)
  val numFiles : t (* NOFILE max number of open files *)
  val lockedInMemorySize : t (* MEMLOCK max locked address space *)
  val numProcesses : t (* NPROC max number of processes *)
  val residentSetSize : t (* RSS max resident set size *)
  val stackSize : t (* STACK max stack size *)
  val virtualMemorySize : t (* AS virtual memory limit *)
  val get : t -> { hard : RLim.t, soft : RLim.t }
  val set : t * { hard : RLim.t, soft : RLim.t } -> unit
end
