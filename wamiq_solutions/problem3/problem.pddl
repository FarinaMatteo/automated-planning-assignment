(define (problem delivery-prob)
    (:domain delivery)
    (:objects
        ag1 - agent

        food_1 food_2 food_3 food_4 med_5 med_6 med_7 med_8 - crate
        
         depot l1 l2 l3 - location

        a1 a2 - agentarea
    )

    (:init
        (at ag1 l3)
        (free a1 ag1)
        (free a2 ag1)
        (closer a1 a2)
        (at food_1 l2)
        (at food_2 l2)
        (at food_3 l3)
        (at food_4 l3)
        (at med_5 l2)
        (at med_6 l2)
        (at med_7 l2)
    
        (connected l1 l2)
        (connected l1 l3)
        (connected l2 l1)
        (connected l2 l3)
        (connected l3 l1)
        (connected l3 l2)
        (deliverable food_2 l1)
        (deliverable food_3 l1)
        (deliverable med_7 l3)
        (at 992.8 (not (deliverable food_2 l1)))
        (at 1866.7 (not (deliverable food_3 l1)))
        (at 2878.0 (not (deliverable med_7 l3)))
        (= (fly-time l1 l2) 215.3)
        (= (fly-time l1 l3) 289.6)
        (= (fly-time l2 l1) 215.3)
        (= (fly-time l2 l3) 306.5)
        (= (fly-time l3 l1) 289.6)
        (= (fly-time l3 l2) 306.5)
    )

    (:goal  (and 
            (at-destination food_1 l3)
            (delivered food_2 l1)
            (delivered food_3 l1)
            (at-destination food_4 l2)
            (at-destination med_5 l3)
            (at-destination med_6 l3)
            (delivered med_7 l3)
            )
    )

    (:metric minimize (total-time)
    )

)
