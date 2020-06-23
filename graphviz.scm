(define-module (graphviz)
  #:export (;; New graphs
            graph
            digraph
            strictgraph
            strictdigraph
            readstring
            read

            ;; New nodes/edges
            node
            edge

            ;; Setting/getting attribute values
            setv
            getv

            ;; Finding and obtaining names
            nameof
            findsubg
            findnode
            findedge
            findattr

            ;; Graph navigators
            headof
            tailof
            graphof
            rootof

            ;; Obtain handles of proto node/edge for setting attribute values
            protonode
            protoedge

            ;; Iterators
            ok
            firstsubg
            nextsubg
            firstsupg
            nextsupg
            firstedge
            nextedge
            firstout
            nextout
            firsthead
            nexthead
            firstin
            nextin
            firstnode
            nextnode
            firstattr
            nextattr

            ;; Remove graph objects
            rm

            ;; Layout
            layout
            render
            renderresult
            renderchannel
            renderdata
            write))

(load-extension "libgv_guile.so" "SWIG_init")
