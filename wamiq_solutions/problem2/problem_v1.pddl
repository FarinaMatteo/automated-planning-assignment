(define (problem logistics-5-1)
(:domain logistics)
(:objects
  apn1 - agent
  apt2 apt1 - airport
   depot pos2 pos1 - location
   cit2 cit1 - city
   tru2 tru1 - carrier
   food_1 food_2 food_3 food_4 food_5 food_6 food_7 food_8 - crate)

(:init 
        (at apn1 apt1) (at tru1 pos1) ;(at obj11 pos1)
        (at food_1 depot) (at food_2 depot) (at food_3 depot) (at food_4 depot) 
        (at food_5 depot) (at food_6 depot) (at food_7 depot) (at food_8 depot)
        ;(at obj12 pos1) (at obj13 pos1) 
        (at tru2 pos2) 
        ;(at obj21 pos2) (at obj22 pos2)(at obj23 pos2) 
        (in-city depot cit1)(in-city pos1 cit1) (in-city apt1 cit1) (in-city pos2 cit2)
        (in-city apt2 cit2))

(:goal (and 
            (at food_1 pos1) (at food_2 pos1) (at food_3 pos2) (at food_4 pos1) (at food_5 pos2) 
            (at food_6 pos1) (at food_7 pos2) (at food_8 pos2)
        )
    )
)