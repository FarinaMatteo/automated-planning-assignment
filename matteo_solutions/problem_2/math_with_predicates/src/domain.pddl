(define (domain assignment-environment)
    (:requirements :typing :equality :negative-preconditions :disjunctive-preconditions)
    (:types
        place - object
        loc warehouse - place
        person - object
        crate - object
        food medicine - crate
        robot - object
        carrier - object
        quantity - object
    )

    (:constants agent - robot
                n0 - quantity
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

        ; mathematical predicates in order to avoid numeric fluents
        (inc ?n ?another_number - quantity) ; should be true if n+1 = another_number
        (dec ?n ?another_number - quantity) ; should be true if n-1 = another_number
        (crates_amount ?c - carrier ?q - quantity) ; should be true if the carrier is holding 'quantity' crates
    )

    ; move the robot ?r from location ?src back to a warehouse in order to load new crates
    (:action back_to_warehouse
        :parameters (?r - robot ?c - carrier ?src - loc ?dst - warehouse)
        :precondition (and
            ; actual action constraints
            (robot_at ?r ?src) (carrier_at ?c ?src)
            ; ensure the robot is not coming back to the depot if any crate is still in the carrier
            (crates_amount ?c n0)
        )
        :effect (and 
            (not (robot_at ?r ?src)) (not (carrier_at ?c ?src)) ; robot and carrier are not at the source location anymore
            (robot_at ?r ?dst) (carrier_at ?c ?dst) ; robot and carrier are at the deposit after moving
        )
    )

    ; move the robot ?r from any place ?src to location ?dst
    (:action move_for_delivery
        :parameters (?r - robot ?c - carrier ?src - place ?dst - loc)
        :precondition (and
            ; actual action constraints
            (robot_at ?r ?src) (carrier_at ?c ?src) (not (= ?src ?dst))
            (not (crates_amount ?c n0))
        )
        :effect (and 
            (not (robot_at ?r ?src)) (not (carrier_at ?c ?src)) ; robot and carrier are not at the source place anymore
            (robot_at ?r ?dst) (carrier_at ?c ?dst); robot and carrier are at the destination location after moving
        )
    )

    ; load the ?end_q crate ?k onto carrier ?c which already has ?start_q crates with robot ?r at warehouse ?wh 
    ; beware that crates can only be loaded at warehouses, not at any place
    (:action load 
        :parameters (?r - robot ?c - carrier ?k - crate ?wh - warehouse ?start_q ?end_q - quantity)
        :precondition (and 
            (robot_at ?r ?wh) (crate_at ?k ?wh) (carrier_at ?c ?wh) ; location constraints
            (not (carrying ?c ?k)) ; ensure the carrier can load the crate
            (inc ?start_q ?end_q) ; ensure this is satisfying the mathematical constraint src_q+1=dst_q
            (crates_amount ?c ?start_q) ; ensure the crate has exactly ?start_q crates before performing this action
        )
        :effect (and 
            (carrying ?c ?k) ; the carrier is actually holding the crate
            (not (crate_at ?k ?wh))
            (crates_amount ?c ?end_q) ; now we have end_q crates rather than start_q crates inside the carrier
            (not (crates_amount ?c ?start_q))
        )
    )

    ; deliver the content of crate ?k to person ?p from robot ?r when at the same location ?l
    ; beware that crates can only be unloaded at locations, since no injured people can be at warehouses
    (:action unload
        :parameters (?r - robot ?c - carrier ?k - crate ?p - person ?l - loc ?start_q ?end_q - quantity)
        :precondition (and 
            (robot_at ?r ?l) (person_at ?p ?l) (carrier_at ?c ?l) ; location constraints
            (carrying ?c ?k) ; make sure we are not trying to unload a crate we don't have!
            (dec ?start_q ?end_q)
            (crates_amount ?c ?start_q)
        )
        :effect (and 
            (not (carrying ?c ?k)) ; the robot is not carrying the crate anymore, so it is free
            (has_crate ?p ?k) ; the crate has been delivered to the person
            (not (crates_amount ?c ?start_q))
            (crates_amount ?c ?end_q)
        )
    )
)