(define (domain assignment-environment)
    (:requirements :typing :equality :negative-preconditions :existential-preconditions)
    (:types
        loc - object
        person - object
        crate - object
        food medicine - crate
        robot - object
        carrier - object
        quantity - object
    )

    (:constants agent - robot)
    
    (:predicates
        ; localization predicates
        (robot-at ?r - robot ?l - loc)
        (person-at ?p - person ?l - loc)
        (crate-at ?k - crate ?l - loc)
        (carrier-at ?c - carrier ?l - loc) ; NOTE: assuming the carrier always moves alongside the agent, in this simple problem is redundant!
        
        ; action-based predicates
        (has-crate ?p - person ?k - crate) ; person p has crate c
        (carrying ?c - carrier ?k - crate) ; crate ?k is contained in carrier ?c

        ; predicates expressing intrinsic properties of entities
        (delivered ?k - crate) ; crate k has been delivered (cannot be loaded on a carrier)

        ; mathematical predicates in order to avoid numeric fluents
        (inc ?n ?another_number) ; should be true if n+1 = another_number
        (dec ?n ?another_number) ; should be true if n-1 = another_number
        (crates-amount ?c - carrier ?q - quantity) ; should be true if the carrier is holding 'quantity' crates
    )

    ; move the robot ?r from location ?src to location ?dst
    (:action Move
        :parameters (?r - robot ?c - carrier ?src ?dst - loc)
        :precondition (and
            ; actual action constraints
            (robot-at ?r ?src) (carrier-at ?c ?src) (not (= ?src ?dst))
        )
        :effect (and 
            (not (robot-at ?r ?src)) (not (carrier-at ?c ?src)) ; robot and carrier are not at the source location anymore
            (robot-at ?r ?dst) (carrier-at ?c ?dst); robot and carrier are at the destination location after moving
        )
    )

    ; load the ?end_q crate ?k onto carrier ?k which already has ?start_q crates with robot ?r at location ?l 
    (:action Load 
        :parameters (?r - robot ?c - carrier ?k - crate ?l - loc ?start_q ?end_q - quantity)
        :precondition (and 
            (robot-at ?r ?l) (crate-at ?k ?l) (carrier-at ?c ?l); location constraints
            (not (carrying ?c ?k)) ; ensure the carrier can load the crate
            (not (delivered ?k)) ; ensure the crate can be loaded onto the robot
            (inc ?start_q ?end_q) ; ensure this is satisfying the mathematical constraint src_q+1=dst_q
            (crates-amount ?c ?start_q) ; ensure the crate has exactly ?start_q crates before performing this action
        )
        :effect (and 
            (carrying ?c ?k) ; the carrier is actually holding the crate
            (crates-amount ?c ?end_q)
            (not (crates-amount ?c ?start_q))
        )
    )

    ; deliver the content of crate ?k to person ?p from robot ?r when at the same location ?l
    (:action Unload
        :parameters (?r - robot ?c - carrier ?k - crate ?p - person ?l - loc ?start_q ?end_q - quantity)
        :precondition (and 
            (robot-at ?r ?l) (person-at ?p ?l) (carrier-at ?c ?l); location constraints
            (carrying ?c ?k) ; make sure we are not trying to unload a crate we don't have!
            (dec ?start_q ?end_q)
            (crates-amount ?c ?start_q)
        )
        :effect (and 
            (not (carrying ?c ?k)) ; the robot is not carrying the crate anymore, so it is free
            (has-crate ?p ?k) (crate-at ?k ?l) ; the crate has been delivered to the person, so it is his/hers property at the same loc.
            (delivered ?k) ; since the person needs the content of the crate, it cannot be reused. So, mark it as delivered.
            (not (crates-amount ?c ?start_q))
            (crates-amount ?c ?end_q)
        )
    )
)