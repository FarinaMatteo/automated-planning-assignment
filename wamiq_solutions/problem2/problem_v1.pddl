(define (problem delivery-prob-1)
    (:domain delivery)
    (:objects
          apn2 apn1 - agent
          
          apt5 apt4 apt3 apt2 apt1 - base
          
          depot pos5 pos4 pos3 pos2 pos1 - location
          
          cit5 cit4 cit3 cit2 cit1 - city
          
          c5 c4 c3 c2 c1 - carrier
          
          food_1 food_2 food_3 food_4 food_5 food_6 food_7 food_8
          med_1 med_2 med_3 med_4 med_5 med_6 med_7 med_8 - crate
    )
    (:init  (at apn1 apt2) (at apn2 apt1) (at c1 pos1) 
            (at food_1 depot) (at food_2 depot) (at food_3 depot) (at food_4 depot) 
            (at food_5 depot) (at food_6 depot) (at food_7 depot) (at food_8 depot)
            (at med_1 depot) (at med_2 depot) (at med_3 depot) (at med_4 depot) 
            (at med_5 depot) (at med_6 depot) (at med_7 depot) (at med_8 depot)
            (at c2 pos2) (at c3 pos3) (at c4 pos4) (at c5 pos5)

            (in-city pos1 cit1)
            (in-city depot cit1)(in-city apt1 cit1) (in-city pos2 cit2) (in-city apt2 cit2) (in-city pos3 cit3)
            (in-city apt3 cit3) (in-city pos4 cit4) (in-city apt4 cit4) (in-city pos5 cit5)
            (in-city apt5 cit5)
    )

    (:goal  (and 
                (at food_1 pos1) (at food_2 pos1) (at food_3 pos2) (at food_4 pos3) (at food_5 pos3) 
                (at food_6 pos4) (at food_7 pos4) (at food_8 pos5)
                (at med_1 pos1) (at med_2 pos2) (at med_3 pos2) (at med_4 pos3) (at med_5 pos4) 
                (at med_6 pos5) (at med_7 pos5) (at med_8 pos4)
                )
    )
)