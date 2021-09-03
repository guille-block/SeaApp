

#Test correct use for input1 module
# return 'Cargo' as it initializes the app
testServer(inputs1, {
  session$setInputs(id_select_1 = unique(ships$ship_type)[1])
  expect_equal(session$returned(), "Cargo")
})

#Test correct use for input1 module
# return '2764' as it initializes the app
testServer(inputs2, {
  session$setInputs(id_select_2 = unique(ships$SHIP_ID)[1])
  expect_equal(session$returned(), 2764)
})



