(define (domain assignment-environment)
    (:requirements :strips :typing :durative-actions)
    (:types
        place - object
        loc warehouse - place
        person - object
        crate - object
        robot - object
        carrier - object
        quantity - object
        zero_quantity - quantity
        non_zero_quantity - quantity
        resource - object
    )

    (:predicates
        ; localization predicates
        (robot_at ?r - robot ?pl - place)
        (person_at ?p - person ?pl - place)
        (crate_at ?k - crate ?pl - place)
        (carrier_at ?c - carrier ?pl - place)
        
        ; action-based predicates
        (has_crate ?p - person ?k - crate) ; person p has crate c
        (carrying ?c - carrier ?k - crate) ; crate ?k is contained in carrier ?c

        ; predicates expressing intrinsic properties of entities
        (free ?r - robot)

        (crate_content ?k - crate ?r - resource)
        (needs ?p - person ?res - resource)
        (doesnt_need ?p - person ?res - resource)

        ; mathematical predicates in order to avoid numeric fluents
        (inc ?n ?another_number - quantity) ; should be true if n+1 = another_number
        (dec ?n ?another_number - quantity) ; should be true if n-1 = another_number
        (crates_amount ?c - carrier ?q - quantity) ; should be true if the carrier is holding 'quantity' crates, as a counter for crates in ?c
    )

    ; move a carrier using a robot from src location to dst warehouse
    (:durative-action back_to_warehouse
        :parameters (?r - robot ?c - carrier ?src - loc ?dst - warehouse ?zero - zero_quantity)
        :duration ( = ?duration 5)
        :condition (and 
            (at start (robot_at ?r ?src))
            (at start (carrier_at ?c ?src))
            (at start (crates_amount ?c ?zero))
            (over all (free ?r))
        )
        :effect (and 
            (at start (not (robot_at ?r ?src)))
            (at start (not (carrier_at ?c ?src)))
            (at end (robot_at ?r ?dst))
            (at end (carrier_at ?c ?dst))
        )
    )

    ; move a carrier using a robot from src place to dst location
    (:durative-action move_for_delivery
        :parameters (?r - robot ?c - carrier ?src - place ?dst - loc ?q - non_zero_quantity)
        :duration ( = ?duration 5)
        :condition (and 
            (at start (robot_at ?r ?src))
            (at start (carrier_at ?c ?src))
            (over all (crates_amount ?c ?q))
            (over all (free ?r))
        )
        :effect (and 
            (at start (not (robot_at ?r ?src)))
            (at start (not (carrier_at ?c ?src)))
            (at end (robot_at ?r ?dst))
            (at end (carrier_at ?c ?dst))
        )
    )

    ; load crate k onto carrier c with robot r at warehouse wh
    (:durative-action load
        :parameters (?r - robot ?c - carrier ?k - crate ?wh - warehouse ?start_q ?end_q - quantity)
        :duration ( = ?duration 2)
        :condition (and 
            (at start (robot_at ?r ?wh))
            (at start (carrier_at ?c ?wh))
            (at start (crate_at ?k ?wh))
            (at start (inc ?start_q ?end_q))
            (at start (crates_amount ?c ?start_q))
            (at start (free ?r))
            ; another robot cannot load the same carrier at the same time or we'll lose track of how many crates are loaded!
            (over all (crates_amount ?c ?start_q))
        )
        :effect (and 
            (at start (not (free ?r)))
            (at end (not (crate_at ?k ?wh)))
            (at end (carrying ?c ?k))
            (at end (crates_amount ?c ?end_q))
            (at end (not (crates_amount ?c ?start_q)))
            (at end (free ?r))
        )
    )

    ; unload crate k from carrier c with robot r and deliver it to person p at the same location
    (:durative-action unload
        :parameters (?r - robot ?c - carrier ?k - crate ?res - resource ?p - person ?l - loc ?start_q ?end_q - quantity)
        :duration ( = ?duration 3)
        :condition (and 
            (at start (robot_at ?r ?l))
            (at start (carrier_at ?c ?l))
            (at start (person_at ?p ?l))
            (at start (dec ?start_q ?end_q))
            (at start (carrying ?c ?k))
            (at start (crate_content ?k ?res))
            (at start (needs ?p ?res))
            (at start (free ?r))
            ; no other agent can unload the carrier at the same time or it will be harmful for our book-keeping of crates!
            (over all (crates_amount ?c ?start_q))
        )
        :effect (and 
            (at start (not (free ?r)))
            (at end (not (carrying ?c ?k)))
            (at end (has_crate ?p ?k))
            (at end (doesnt_need ?p ?res))
            (at end (not (needs ?p ?res)))
            (at end (not (crates_amount ?c ?start_q)))
            (at end (crates_amount ?c ?end_q))
            (at end (free ?r))
        )
    )
)