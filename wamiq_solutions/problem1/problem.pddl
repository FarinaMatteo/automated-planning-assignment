(define (problem delivery-problems)
  (:domain delivery)
  (:objects 
      
      ; declaration of location and assuming person at particular location
      depot loc_1 loc_2 loc_3 loc_4 loc_5 loc_6 loc_7 loc_8 loc_9 loc_10 loc_11 loc_12 loc_13 loc_14 loc_15 
      loc_16 loc_17 loc_18 loc_19 loc_20 loc_21 loc_22 loc_23 loc_24 loc_25 loc_26 loc_27 loc_28 loc_29 loc_30 
      loc_31 loc_32 loc_33 loc_34 loc_35 loc_36 loc_37 loc_38 loc_39 loc_40 loc_41 loc_42 loc_43 loc_44 loc_45 
      loc_46 loc_47 loc_48 loc_49 loc_50 
  
	;Crate for food and medicines
	crate_1 crate_2 crate_3 crate_4 crate_5 crate_6 crate_7 crate_8 crate_9 crate_10 crate_11 crate_12 crate_13 crate_14 crate_15 
	crate_16 crate_17 crate_18 crate_19 crate_20 crate_21 crate_22 crate_23 crate_24 crate_25 crate_26 crate_27 crate_28 
	crate_29 crate_30 crate_31 crate_32 crate_33 crate_34 crate_35 crate_36 crate_37 crate_38 crate_39 crate_40 crate_41 
	crate_42 crate_43 crate_44 crate_45 crate_46 crate_47 crate_48 crate_49 crate_50 
	
	right
  )
	    
  (:init 

        ; location intialization 
        (LOC depot)(LOC loc_1) (LOC loc_2) (LOC loc_3) (LOC loc_4) (LOC loc_5) (LOC loc_6) (LOC loc_7) (LOC loc_8) (LOC loc_9) 
        (LOC loc_10) (LOC loc_11) (LOC loc_12) (LOC loc_13) (LOC loc_14) (LOC loc_15) (LOC loc_16) (LOC loc_17) (LOC loc_18) (LOC loc_19)
        (LOC loc_20) (LOC loc_21) (LOC loc_22) (LOC loc_23) (LOC loc_24) (LOC loc_25) (LOC loc_26) (LOC loc_27) (LOC loc_28) (LOC loc_29)
        (LOC loc_30) (LOC loc_31) (LOC loc_32) (LOC loc_33) (LOC loc_34) (LOC loc_35) (LOC loc_36) (LOC loc_37) (LOC loc_38) (LOC loc_39)
        (LOC loc_40) (LOC loc_41) (LOC loc_42) (LOC loc_43) (LOC loc_44) (LOC loc_45) (LOC loc_46) (LOC loc_47) (LOC loc_48) (LOC loc_49)
        (LOC loc_50) 
        
        ; crate intialization 
        (CRATE crate_1) (CRATE crate_2) (CRATE crate_3) (CRATE crate_4) (CRATE crate_5) (CRATE crate_6) (CRATE crate_7) (CRATE crate_8) 
        (CRATE crate_9) (CRATE crate_10) (CRATE crate_11) (CRATE crate_12) (CRATE crate_13) (CRATE crate_14) (CRATE crate_15)
        (CRATE crate_16) (CRATE crate_17) (CRATE crate_18) (CRATE crate_19) (CRATE crate_20) (CRATE crate_21) (CRATE crate_22)
        (CRATE crate_23) (CRATE crate_24) (CRATE crate_25) (CRATE crate_26) (CRATE crate_27) (CRATE crate_28) (CRATE crate_29) 
        (CRATE crate_30) (CRATE crate_31) (CRATE crate_32) (CRATE crate_33) (CRATE crate_34) (CRATE crate_35) (CRATE crate_36) 
        (CRATE crate_37) (CRATE crate_38) (CRATE crate_39) (CRATE crate_40) (CRATE crate_41) (CRATE crate_42) (CRATE crate_43) 
        (CRATE crate_44) (CRATE crate_45) (CRATE crate_46) (CRATE crate_47) (CRATE crate_48) (CRATE crate_49) (CRATE crate_50)
        
        (AGENT right) 
        (free right) (at-rob depot)
        
        ; Intially all crate at depot
        (at-crate crate_1 depot) (at-crate crate_2 depot) (at-crate crate_3 depot) (at-crate crate_4 depot) (at-crate crate_5 depot) 
        (at-crate crate_6 depot) (at-crate crate_7 depot) (at-crate crate_8 depot) (at-crate crate_9 depot) (at-crate crate_10 depot) 
        (at-crate crate_11 depot) (at-crate crate_12 depot) (at-crate crate_13 depot) (at-crate crate_14 depot) (at-crate crate_15 depot) 
        (at-crate crate_16 depot) (at-crate crate_17 depot) (at-crate crate_18 depot) (at-crate crate_19 depot) (at-crate crate_20 depot) 
        (at-crate crate_21 depot) (at-crate crate_22 depot) (at-crate crate_23 depot) (at-crate crate_24 depot) (at-crate crate_25 depot) 
        (at-crate crate_26 depot) (at-crate crate_27 depot) (at-crate crate_28 depot) (at-crate crate_29 depot) (at-crate crate_30 depot)
        (at-crate crate_31 depot) (at-crate crate_32 depot) (at-crate crate_33 depot) (at-crate crate_34 depot) (at-crate crate_35 depot) 
        (at-crate crate_36 depot) (at-crate crate_37 depot) (at-crate crate_38 depot) (at-crate crate_39 depot) (at-crate crate_40 depot)
        (at-crate crate_41 depot) (at-crate crate_42 depot) (at-crate crate_43 depot) (at-crate crate_44 depot) (at-crate crate_45 depot) 
        (at-crate crate_46 depot) (at-crate crate_47 depot) (at-crate crate_48 depot) (at-crate crate_49 depot) (at-crate crate_50 depot)
  )
	 
  (:goal 
        (and (at-crate crate_1 loc_1) (at-crate crate_2 loc_2) (at-crate crate_3 loc_3) (at-crate crate_4 loc_4) 
        (at-crate crate_5 loc_5) (at-crate crate_6 loc_6) (at-crate crate_7 loc_7) (at-crate crate_8 loc_8) 
        (at-crate crate_9 loc_9) (at-crate crate_10 loc_10) (at-crate crate_11 loc_11) (at-crate crate_12 loc_12) 
        (at-crate crate_13 loc_13) (at-crate crate_14 loc_14) (at-crate crate_15 loc_15) (at-crate crate_16 loc_16) 
        (at-crate crate_17 loc_17) (at-crate crate_18 loc_18) (at-crate crate_19 loc_19) (at-crate crate_20 loc_20)  
        (at-crate crate_21 loc_21)(at-crate crate_22 loc_22) (at-crate crate_23 loc_23) (at-crate crate_24 loc_24)  
        (at-crate crate_25 loc_25)(at-crate crate_26 loc_26) (at-crate crate_27 loc_27) (at-crate crate_28 loc_28) 
        (at-crate crate_29 loc_29) (at-crate crate_30 loc_30) (at-crate crate_31 loc_31) (at-crate crate_32 loc_32) 
        (at-crate crate_33 loc_33)(at-crate crate_34 loc_34) (at-crate crate_35 loc_35) (at-crate crate_36 loc_36)  
        (at-crate crate_37 loc_37)(at-crate crate_38 loc_38) (at-crate crate_39 loc_39) (at-crate crate_40 loc_40) 
        (at-crate crate_41 loc_41) (at-crate crate_42 loc_42) (at-crate crate_43 loc_43) (at-crate crate_44 loc_44) 
        (at-crate crate_45 loc_45) (at-crate crate_46 loc_46) (at-crate crate_47 loc_47) (at-crate crate_48 loc_48) 
        (at-crate crate_49 loc_49) (at-crate crate_50 loc_50) 
        )
  )
  )
