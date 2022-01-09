(define (problem problem_two) (:domain assignment-environment)
(:objects 
    ; let's suppose 11 random locations directly connected to each other
    depot l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - loc
    ; let's suppose 3 people 
    Alice Wamiq Zihadul Federico Matteo Gianmarco - person
    ; let's suppose 6 crates, 3 containing food and 3 containing medicine (subtypes of crate!)
    c0 c1 c2 - food
    c3 c4 c5 - medicine 
    ; unique carrier object
    carr - carrier
)

(:init
    ; let's suppose all People are in different locations
    (person-at Wamiq l0) (person-at Zihadul l5) (person-at Alice l8)
    (person-at Federico l4) (person-at Matteo l7) (person-at Gianmarco l0)
    
    ; every crate as well as the agent and the carrier are in the 'depot'
    (crate-at c0 depot) (crate-at c1 depot) (crate-at c2 depot) (crate-at c3 depot) (crate-at c4 depot) (crate-at c5 depot)
    (robot-at agent depot) (carrier-at carr depot)
    
    ; in closed-world assumptions, we must mark the carrier as free in the beginning (free = with 0 crates). Otherwise, it cannot pick crates!
    (= (crates-amount carr) 0)
)

(:goal (and
    ; random definition of what people need
    ; let's suppose Wamiq needs FOOD, while Zihadul and Alice need MEDICINE
    (or (has-crate Wamiq c0) (has-crate Wamiq c1) (has-crate Wamiq c2))
    (or (has-crate Federico c0) (has-crate Federico c1) (has-crate Federico c2))
    (or (has-crate Alice c0) (has-crate Alice c1) (has-crate Alice c2))

    (or (has-crate Gianmarco c3) (has-crate Gianmarco c4) (has-crate Gianmarco c5))
    (or (has-crate Zihadul c3) (has-crate Zihadul c4) (has-crate Zihadul c5))
    (or (has-crate Matteo c3) (has-crate Matteo c4) (has-crate Matteo c5))
))

)
