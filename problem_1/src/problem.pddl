(define (problem problem_one) (:domain injured-people-environment)
(:objects 
    ; let's suppose 11 random locations directly connected to each other
    depot l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - loc
    alice wamiq zihadul matteo - person
    ; let's suppose 6 crates, 3 containing food and 3 containing medicine (subtypes of crate!)
    f0 f1 f2 - food
    m3 m4 m5 - medicine 
)

(:init
    ; let's suppose all People are in different locations
    (person_at wamiq l0)
    (person_at zihadul l5)
    (person_at alice l8)
    (person_at matteo l4)
    
    ; every crate as well as the agent are in the 'depot'
    (crate_at f0 depot) (crate_at f1 depot) (crate_at f2 depot) (crate_at m3 depot) (crate_at m4 depot) (crate_at m5 depot)
    (robot_at agent depot)
    
    ; in closed-world assumptions, we must mark the agent as free in the beginning. Otherwise, it cannot pick crates!
    (free agent)
)

(:goal (and
    ; >>> random definition of what people need >>>

    ; wamiq only needs food
    (or (has_crate wamiq f0) (has_crate wamiq f1) (has_crate wamiq f2))

    ; alternative definition with :existential-preconditions
    ; (exists (?c - food) (and (has_crate wamiq ?c)))

    ; zihadul only needs medicine
    (or (has_crate zihadul m3) (has_crate zihadul m4) (has_crate zihadul m5))

    ; alternative definition with :existential-preconditions
    ; (exists (?c - medicine) (and (has_crate zihadul ?c)))
    
    ; matteo doesn't need anything, so he mustn't be given any crate
    (not (or (has_crate matteo f0) (has_crate matteo f1) (has_crate matteo f2)))
    (not (or (has_crate matteo m3) (has_crate matteo m4) (has_crate matteo m5)))
    
    ; alternative definition with :existential-preconditions
    ; (not (exists (?c - food) (and (has_crate matteo ?c))))
    ; (not (exists (?c - medicine) (and (has_crate matteo ?c))))

    ; alice needs both food and medicine
    (or (has_crate alice m3) (has_crate alice m4) (has_crate alice m5))
    (or (has_crate alice f0) (has_crate alice f1) (has_crate alice f2))

    ; alternative definition with :existential-preconditions
    ; (exists (?c - medicine) (and (has_crate alice ?c)))
    ; (exists (?c - food) (and (has_crate alice ?c)))

    ; <<< random definition of what people need <<<
))

)
