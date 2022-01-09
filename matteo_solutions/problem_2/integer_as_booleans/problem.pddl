(define (problem problem_two) (:domain assignment-environment)
(:objects 
    ; let's suppose 11 random locations directly connected to each other
    depot l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - loc
    ; let's suppose 3 people 
    Alice Wamiq Zihadul Matteo Federico Gianmarco - person
    ; let's suppose 6 crates, 3 containing food and 3 containing medicine (subtypes of crate!)
    c0 c1 c2 - food
    c3 c4 c5 - medicine 
    ; unique carrier object
    carr - carrier
    ; define quantities between 0 to 4
    n0 n1 n2 n3 n4 - quantity
)

(:init
    ; let's suppose all People are in different locations
    (person-at Wamiq l0) (person-at Zihadul l5) (person-at Alice l8)
    (person-at Matteo l3) (person-at Federico l9) (person-at Gianmarco l7)
    
    ; every crate as well as the agent and the carrier are in the 'depot'
    (crate-at c0 depot) (crate-at c1 depot) (crate-at c2 depot) (crate-at c3 depot) (crate-at c4 depot) (crate-at c5 depot)
    (robot-at agent depot) (carrier-at carr depot)
    
    ; in closed-world assumptions, we must mark the carrier as free in the beginning (free = with 0 crates). Otherwise, it cannot pick crates!
    (crates-amount carr n0)

    ; then, let's define increment - decrement relationships among 'quantity' objects
    (inc n0 n1) (inc n1 n2) (inc n2 n3) (inc n3 n4)
    (dec n4 n3) (dec n3 n2) (dec n2 n1) (dec n1 n0)
)

(:goal (and
    ; random definition of what people need
    ; let's suppose Wamiq needs FOOD, while Zihadul and Alice need MEDICINE
    (exists (?c - food) (and (has-crate Wamiq ?c) ))
    (exists (?c - food) (and (has-crate Matteo ?c) ))
    (exists (?c - food) (and (has-crate Federico ?c) ))
    (exists (?c - medicine) (and (has-crate Zihadul ?c) ))
    (exists (?c - medicine) (and (has-crate Alice ?c) ))
    (exists (?c - medicine) (and (has-crate Gianmarco ?c) ))
))

)
