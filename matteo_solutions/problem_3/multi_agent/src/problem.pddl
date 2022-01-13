(define (problem problem_three) (:domain assignment-environment)
(:objects 
    ; let's suppose 10 random locations directly connected to each other
    l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - loc
    alice wamiq zihadul matteo federico gianmarco - person
    ; let's suppose 6 crates, 3 containing food and 3 containing medicine (subtypes of crate!)
    f0 f1 f2 m3 m4 m5 - crate 
    ; carrier objects
    carr another_carr - carrier
    ; additional agent
    another_agent - robot
    ; define quantities from 1 to 4
    n1 n2 n3 n4 - quantity
    ; crate content types for the problem
    food medicine - resource
)

(:init
    ; let's suppose all People are in different locations
    (person_at wamiq l5) (person_at zihadul l3) (person_at alice l8)
    (person_at matteo l3) (person_at federico l9) (person_at gianmarco l7)
    
    ; every crate as well as the agent and the carrier are in the 'depot'
    (crate_at f0 depot) (crate_at f1 depot) (crate_at f2 depot) (crate_at m3 depot) (crate_at m4 depot) (crate_at m5 depot)
    (robot_at agent depot) (carrier_at carr depot)
    (robot_at another_agent depot) (carrier_at another_carr depot)
    
    ; in closed-world assumptions, we must mark the carrier as free in the beginning (free = with 0 crates). Otherwise, it cannot pick crates!
    (crates_amount carr n0)
    (crates_amount another_carr n0)

    ; then, let's define increment - decrement relationships among 'quantity' objects
    (inc n0 n1) (inc n1 n2) (inc n2 n3) (inc n3 n4)
    (dec n4 n3) (dec n3 n2) (dec n2 n1) (dec n1 n0)

    (free agent)
    (free another_agent)

    ; >>> random definition of what people need >>>

    ; wamiq needs only food
    (needs wamiq food) (doesnt_need wamiq medicine)
    
    ; matteo needs only medicine
    (needs matteo medicine) (doesnt_need matteo food)
    
    ; zihadul needs both food and medicine
    (needs zihadul food) (needs zihadul medicine)
    
    ; federico and alice don't need anything
    (doesnt_need federico food) (doesnt_need federico medicine)
    (doesnt_need alice food) (doesnt_need alice medicine)
    
    ; gianmarco needs only medicine
    (needs gianmarco medicine) (doesnt_need gianmarco food)

    ; <<< random definitions of what people need <<<

    ; random definition of crate contents (3 with food, 3 with medicine)
    (crate_content f0 food) (crate_content f1 food) (crate_content f2 food)
    (crate_content m3 medicine) (crate_content m4 medicine) (crate_content m5 medicine)
)

(:goal (and
    ; make sure every person is not in need of anything
    (doesnt_need matteo food) (doesnt_need matteo medicine)
    (doesnt_need federico food) (doesnt_need federico medicine)
    (doesnt_need alice food) (doesnt_need alice medicine)
    (doesnt_need wamiq food) (doesnt_need wamiq medicine)
    (doesnt_need zihadul food) (doesnt_need zihadul medicine)
    (doesnt_need gianmarco food) (doesnt_need gianmarco medicine)
))

(:metric minimize (total-time))
)
