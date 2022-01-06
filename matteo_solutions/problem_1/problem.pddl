(define (problem problem_one) (:domain injured-people-environment)
(:objects 
    ; let's suppose 11 random locations directly connected to each other
    depot l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - loc
    ; let's suppose 3 people 
    Alice Wamiq Zihadul - person
    ; let's suppose 6 crates, 3 containing food and 3 containing medicine (subtypes of crate!)
    c0 c1 c2 - food
    c3 c4 c5 - medicine 
)

(:init
    ; let's suppose all People are in different locations
    (person-at Wamiq l0) (person-at Zihadul l5) (person-at Alice l8)
    
    ; every crate as well as the agent are in the 'depot'
    (crate-at c0 depot) (crate-at c1 depot) (crate-at c2 depot) (crate-at c3 depot) (crate-at c4 depot) (crate-at c5 depot)
    (robot-at agent depot)
    
    ; in closed-world assumptions, we must mark the agent as free in the beginning. Otherwise, it cannot pick crates!
    (Free agent)
)

(:goal (and
    ; random definition of what people need
    ; let's suppose Wamiq needs FOOD, while Zihadul and Alice need MEDICINE
    (exists (?c - food) (and (has-crate Wamiq ?c)))
    (exists (?c - medicine) (and (has-crate Zihadul ?c)))
    (exists (?c - medicine) (and (has-crate Alice ?c)))
))

)
