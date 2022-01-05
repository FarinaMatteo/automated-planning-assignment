(define (problem problem_one) (:domain injured-people-environment)
(:objects 
    ; let's suppose 11 random locations directly connected to each other
    depot l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - Loc
    ; let's suppose 3 people 
    Alice Wamiq Zihadul - Person
    ; let's suppose 6 crates
    c0 c1 c2 c3 c4 c5 - Crate
    ; ... and our unique agent
    agent - Robot
)

(:init
    ;todo: put the initial state's facts and numeric values here
    ; let's suppose all People are in different locations
    (At Wamiq l0) (At Zihadul l5) (At Alice l8)
    ; every crate as well as the agent are in the 'depot'
    (At c0 depot) (At c1 depot) (At c2 depot) (At c3 depot) (At c4 depot) (At c5 depot)
    (At agent depot)
    ; random definition of crate contents
    (Has c0 FOOD) (Has c1 FOOD) (Has c2 FOOD) 
    (Has c3 MEDICINE) (Has c4 MEDICINE) (Has c5 MEDICINE)
    (Free agent)
)

(:goal (and
    ; random definition of what people need
    ; let's suppose Wamiq needs FOOD, while Zihadul and Alice need MEDICINE
    (exists (?c - Crate) (and (Has Wamiq ?c) (Has ?c FOOD)))
    (exists (?c - Crate) (and (Has Zihadul ?c) (Has ?c MEDICINE)))
    (exists (?c - Crate) (and (Has Alice ?c) (Has ?c MEDICINE)))
))

)
