(define (domain assignment-environment)
    (:requirements :typing :equality :negative-preconditions :existential-preconditions :fluents :disjunctive-preconditions)
    (:types
        place - object
        loc warehouse - place
        person - object
        crate - object
        food medicine - crate
        robot - object
        carrier - object
    )

    (:constants agent - robot
                depot - warehouse)
    
    (:predicates
        ; localization predicates
        (robot_at ?r - robot ?pl - place)
        (person_at ?p - person ?pl - place)
        (crate_at ?k - crate ?pl - place)
        (carrier_at ?c - carrier ?pl - place) ; NOTE: assuming the carrier always moves alongside the agent, in this simple problem is redundant!
        
        ; action-based predicates
        (has_crate ?p - person ?k - crate) ; person p has crate c
        (carrying ?c - carrier ?k - crate) ; crate ?k is contained in carrier ?c
    )

    ; defining the functions (aka numeric-fluents) for the problem
    (:functions
        ; the problem says 'the robotic agent can load up to 4 crates onto a carrier', so keep track of it
        (crates_amount ?c - carrier)
    )

    ; move the robot ?r from location ?src to location ?dst
    (:action move_to_depot
        :parameters (?r - robot ?c - carrier ?src - loc)
        :precondition (and
            ; actual action constraints
            (robot_at ?r ?src) (carrier_at ?c ?src)
            (= (crates_amount ?c) 0)
        )
        :effect (and 
            (not (robot_at ?r ?src)) (not (carrier_at ?c ?src)) ; robot and carrier are not at the source location anymore
            (robot_at ?r depot) (carrier_at ?c depot); robot and carrier are at the destination location after moving
        )
    )

    ; move the robot ?r from location ?src to location ?dst
    (:action move_for_delivery
        :parameters (?r - robot ?c - carrier ?src - place ?dst - loc)
        :precondition (and
            ; actual action constraints
            (robot_at ?r ?src) (carrier_at ?c ?src) (not (= ?src ?dst))
        )
        :effect (and 
            (not (robot_at ?r ?src)) (not (carrier_at ?c ?src)) ; robot and carrier are not at the source location anymore
            (robot_at ?r ?dst) (carrier_at ?c ?dst); robot and carrier are at the destination location after moving
        )
    )

    ; load the crate ?k onto carrier ? with robot ?r at location ?l
    (:action load 
        :parameters (?r - robot ?c - carrier ?k - crate ?l - warehouse)
        :precondition (and 
            (robot_at ?r ?l) (crate_at ?k ?l) (carrier_at ?c ?l); location constraints
            (not (carrying ?c ?k)) (< (crates_amount ?c) 4) ; ensure the carrier can load the crate
        )
        :effect (and 
            (carrying ?c ?k)
            (not (crate_at ?k ?l))
            (increase (crates_amount ?c) 1) ; the carrier is actually holding the crate, so it is not free anymore
        )
    )

    ; deliver the content of crate ?k to person ?p from robot ?r when at the same location ?l
    (:action unload
        :parameters (?r - robot ?c - carrier ?k - crate ?p - person ?l - loc)
        :precondition (and 
            (robot_at ?r ?l) (person_at ?p ?l) (carrier_at ?c ?l); location constraints
            (carrying ?c ?k) ; make sure we are not trying to unload a crate we don't have!
            (> (crates_amount ?c) 0)
        )
        :effect (and 
            (not (carrying ?c ?k)) ; the robot is not carrying the crate anymore, so it is free
            (has_crate ?p ?k) ; the crate has been delivered to the person
            (decrease (crates_amount ?c) 1)
        )
    )
)