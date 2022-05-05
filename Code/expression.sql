--ADDING TIMESTAMP TO POINTS

with_variable('speed', 20,                             -- setting the speed variable
    with_variable('start_time', make_datetime(2022,1,25,20, 0 ,0),   -- setting a start time variable
        CASE 
            WHEN "distance" = 0                        
            THEN @start_time                           -- input the start time at zero distance
            
            ELSE @start_time + to_interval(to_string("distance" / @speed) || ' seconds')  -- adding the interval (distance/speed) to the start time and calculating the remaining rows 
        END
    )
)

------------------------------------------------------------------------------------------------------

--UPDATING TIMESTAMP ACCORDING TO THE ANGLE DIFFERENCE 
--Angle difference shows if there is any turn in the route

with_variable('rangle', abs("angle" - attribute(get_feature_by_id(@layer, $id - 1), 'angle')), -- comparing to the previous angle and finding the relative angle
    with_variable('threshold', 40,   -- setting a threshold variable
        with_variable('dist', 40,
            with_variable('start_time', make_datetime(2022, 1, 25, 20, 0 ,0),   -- setting a start time variable
                    CASE 
                        WHEN "distance" = 0                        
                        THEN @start_time          -- input the start time at zero distance
                        
                        ELSE 
                        
                            CASE WHEN @rangle < @threshold 
                                THEN attribute(get_feature_by_id(@layer, $id-1), 'timestamp') + to_interval(to_string(@dist / 20) || ' seconds')  -- getting the time from the previous row and adding the interval (distance/speed)
                                
                            ELSE                        
                                attribute(get_feature_by_id(@layer, $id-1), 'timestamp') + to_interval(to_string(@dist / 8) || ' seconds')  -- when the angle is above threshold, using a slower speed.
                            END
                            
                    END
            )
        )
    )
)

