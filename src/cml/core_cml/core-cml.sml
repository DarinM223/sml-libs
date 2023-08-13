
signature CML =
  sig
    val version : {system : string, version_id : int list, date : string}
    val banner : string

    type thread_id
    type 'a event
    val sameTid    : (thread_id * thread_id) -> bool
    val compareTid : (thread_id * thread_id) -> order
    val hashTid    : thread_id -> word
    val tidToString : thread_id -> string

    val getTid : unit -> thread_id
    val spawnc : ('a -> unit) -> 'a -> thread_id
    val spawn  : (unit -> unit) -> thread_id
    val exit   : unit -> 'a
    val yield  : unit -> unit  (* mostly for benchmarking *)
    val joinEvt : thread_id -> unit event
    (* thread-local data *)
    val newThreadProp : (unit -> 'a) ->
       {
        clrFn : unit -> unit,          (* clear's current thread's property *)
        getFn : unit -> 'a,            (* get current thread's property; if *)
                                       (* the property is not defined, then *)
                                       (* it sets it using the initialization *)
                                       (* function. *)
        peekFn : unit -> 'a option,    (* return the property's value, if any *)
        setFn : 'a -> unit             (* set the property's value for the *)
                                       (* current thread. *)
        }
    val newThreadFlag : unit -> {getFn : unit -> bool, setFn : bool -> unit}

    type 'a chan
    val channel : unit -> 'a chan
    val sameChannel : ('a chan * 'a chan) -> bool
    val send : ('a chan * 'a) -> unit
    val recv : 'a chan -> 'a
    val sendEvt  : ('a chan * 'a) -> unit event
    val recvEvt  : 'a chan -> 'a event
    val sendPoll : ('a chan * 'a) -> bool
    val recvPoll : 'a chan -> 'a option

    val never     : 'a event
    val alwaysEvt : 'a -> 'a event
    val wrap        : ('a event * ('a -> 'b)) -> 'b event
    val wrapHandler : ('a event * (exn -> 'a)) -> 'a event
    val guard    : (unit -> 'a event) -> 'a event
    val withNack : (unit event -> 'a event) -> 'a event
    val choose : 'a event list -> 'a event
    val sync : 'a event -> 'a
    val select : 'a event list -> 'a

    val timeOutEvt : Time.time -> unit event
    val atTimeEvt  : Time.time -> unit event
  end

structure CML : CML = struct end

signature SYNC_VAR =
   sig

      type 'a ivar  (* I-structure variable *)
      type 'a mvar  (* M-structure variable *)

      exception Put (* raised on put operations to full cells *)

      val iVar     : unit -> 'a ivar
      val iPut     : ('a ivar * 'a) -> unit
      val iGet     : 'a ivar -> 'a
      val iGetEvt  : 'a ivar -> 'a CML.event
      val iGetPoll : 'a ivar -> 'a option
      val sameIVar : ('a ivar * 'a ivar) -> bool

      val mVar      : unit -> 'a mvar
      val mVarInit  : 'a -> 'a mvar
      val mPut      : ('a mvar * 'a) -> unit
      val mTake     : 'a mvar -> 'a
      val mTakeEvt  : 'a mvar -> 'a CML.event
      val mTakePoll : 'a mvar -> 'a option
      val mGet      : 'a mvar -> 'a
      val mGetEvt   : 'a mvar -> 'a CML.event
      val mGetPoll  : 'a mvar -> 'a option
      val mSwap     : ('a mvar * 'a) -> 'a
      val mSwapEvt  : ('a mvar * 'a) -> 'a CML.event
      val sameMVar  : ('a mvar * 'a mvar) -> bool
   end

structure SyncVar : SYNC_VAR = struct end

signature MAILBOX =
   sig
      type 'a mbox

      val mailbox     : unit -> 'a mbox
      val sameMailbox : ('a mbox * 'a mbox) -> bool

      val send     : ('a mbox * 'a) -> unit
      val recv     : 'a mbox -> 'a
      val recvEvt  : 'a mbox -> 'a CML.event
      val recvPoll : 'a mbox -> 'a option
   end

structure MailBox : MAILBOX = struct end

signature RUN_CML =
   sig
      val isRunning : unit -> bool
      val doit : (unit -> unit) * Time.time option -> OS.Process.status
      val shutdown : OS.Process.status -> 'a
   end

structure RunCML : RUN_CML = struct end