(define (problem delivery-prob2)
  (:domain delivery-p2)
  (:objects 
          ; declation person at location
          depot p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
  
          ; agent declation
          r1 r2 r3 r4

          ; crate consist of food and medicine and their decleration 
          crate_1 crate_2 crate_3 crate_4 crate_5 crate_6 crate_7 crate_8 crate_9 crate_10 crate_11 crate_12 crate_13 crate_14
	    )
  (:init
          ; capacity intialization all robot has 0 capacity
          (= (capacity r1) 0) (= (capacity r2) 0)
          (= (capacity r3) 0) (= (capacity r4) 0)
  

            (at-location depot)
            
            ; intialization of person at location 
            (at-location p1) (at-location p2) (at-location p3) (at-location p4) (at-location p5) 
            (at-location p6) (at-location p7) (at-location p8) (at-location p9) (at-location p10) (at-location p11) 
            (at-location p12) (at-location p13) (at-location p14)
   
            ; intialization agents
            (agent r1) (agent r2) (agent r3) (agent r4) 
   
            ; intialization of crate
            (crate crate_1) (crate crate_2) (crate crate_3) (crate crate_4) (crate crate_5) (crate crate_6) (crate crate_7) (crate crate_8) 
            (crate crate_9) (crate crate_10) (crate crate_11) (crate crate_12) (crate crate_13) (crate crate_14)
   
            ; intialization of agent at location depot
            (at r1 depot) (at r2 depot) (at r3 depot) (at r4 depot)
   
            ; intialization of all crate at location depot
            (at crate_1 depot) (at crate_2 depot) (at crate_3 depot) (at crate_4 depot) (at crate_5 depot) (at crate_6 depot) (at crate_7 depot) 
            (at crate_8 depot) (at crate_9 depot) (at crate_10 depot) (at crate_11 depot) (at crate_12 depot) (at crate_13 depot) (at crate_14 depot)
   
   )
   
  (:goal (and 
              (at crate_1 p1) (at crate_2 p2) (at crate_3 p3) (at crate_4 p4) (at crate_5 p5) (at crate_6 p6) 
              (at crate_7 p7) (at crate_8 p8) (at crate_9 p9) (at crate_10 p10) (at crate_11 p11) 
              (at crate_12 p12) (at crate_13 p13) (at crate_14 p14)
          )
  )
  )
