signature MULTICAST =
   sig
      type 'a mchan
      type 'a port
      type 'a event = 'a CML.event

      (* create a new multicast channel *)
      val mChannel : unit -> 'a mchan
      (* create a new output port on a channel *)
      val port : 'a mchan -> 'a port
      (* create a new output port on a channel that has the same state as the
       * given port.  I.e., the stream of messages seen on the two ports will
       * be the same.
       * NOTE: if two (or more) independent threads are reading from the
       * same port, then the copy operation may not be accurate.
       *)
      val copy : 'a port -> 'a port
      (* receive a message from a port *)
      val recv : 'a port -> 'a
      val recvEvt : 'a port -> 'a event
      (* send a message to all of the ports of a channel *)
      val multicast : ('a mchan * 'a) -> unit
   end

structure Multicast : MULTICAST = struct end

signature SIMPLE_RPC =
   sig
      type 'a event = 'a CML.event

      val mkRPC : ('a -> 'b) ->
         {call     : 'a -> 'b,
          entryEvt : unit event}

      val mkRPC_In : (('a * 'c) -> 'b) ->
         {call     : 'a -> 'b,
          entryEvt : 'c -> unit event}

      val mkRPC_Out : ('a -> ('b * 'c)) ->
         {call     : 'a -> 'b,
          entryEvt : 'c event}

      val mkRPC_InOut : (('a * 'c) -> ('b * 'd)) ->
         {call     : 'a -> 'b,
          entryEvt : 'c -> 'd event}
  end

structure SimpleRPC : SIMPLE_RPC = struct end