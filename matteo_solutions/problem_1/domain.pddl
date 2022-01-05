(define (domain injured-people-environment)
    (:requirements :typing :equality :negative-preconditions :existential-preconditions)
    (:types
        Loc
        Person
        Resource
        Crate
        Robot
    ) 
    (:constants FOOD MEDICINE - Resource)
    (:predicates 
        (Injured ?p)
        ; localization predicates
        (At ?x ?l) ; entity x (Robot, Crate, Person) is at Location l
        ; action-based predicates
        (Has ?x ?o)
        (Free ?r)
        (Carrying ?r ?c) ; Robot r is carrying Crate c
        (Taken ?c) ; Crate c is taken (cannot be Loaded)
    )

    ; defining the possible actions of the problem
    (:action Move ; move the robot ?r from location ?src to location ?dst
        :parameters (?r - Robot ?src - Loc ?dst - Loc)
        :precondition (and
            ; actual action constraints
            (At ?r ?src) (not (= ?src ?dst))
        )
        :effect (and 
            (not (at ?r ?src))
            (at ?r ?dst)
        )
    
    )
    (:action Load ; load the Crate ?c onto Robot ?r at Location ?l
        :parameters (?r - Robot ?c - Crate ?l - Loc)
        :precondition (and 
            ; actual action constraints
            (At ?r ?l) (At ?c ?l) (not (Carrying ?r ?c)) (not (Taken ?c)) (Free ?r)
        )
        :effect (and 
            (Carrying ?r ?c) (not (Free ?r))
        )
    )
    (:action Unload ; deliver the content of Crate ?c to Person ?p from Robot ?r when at the same Location ?l
        :parameters (?r - Robot ?c - Crate ?p - Person ?l - Loc)
        :precondition (and 
            ; actual action constraints
            (At ?r ?l) (Carrying ?r ?c) (At ?p ?l)
        )
        :effect (and 
            (not (Carrying ?r ?c)) (Free ?r) (Has ?p ?c) (At ?c ?l) (Taken ?c)
        )
    )
)