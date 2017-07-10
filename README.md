## Easy set up instructions:

1.  After unzipping the file, navigate to the strider_solution directory in your terminal.    

2.  Run bundle to install the rspec gem : `$ bundle`

3.  Run the rspec command to execute all the tests in the spec folder : `$ rspec`

4.  Open up the strider_solution directory in the text editor of your choice and inside
    you will see a directory called inputs, which currently has 1 file called orders.csv

5.  The strider_solution directory also has a directory called output, which is currently empty.

6.  In our terminal let's navigate to the lib directory inside the strider_solution directory `$ cd lib/`

7.  Now we will run our create_csv.rb file to generate our redemptions.csv `$ ruby create_csv.rb`

8.  You should see the following message :
    "Your redemptions.csv file has been successfully created and is located in the output directory"

9.  Let's check our output directory inside of our strider_solution directory and sure enough it's there!

10. If you want to put in your own orders.csv file, simply replace the one currently in the input directory
    with your orders.csv file and simply repeat steps 6 and 7.


#### input/orders.csv
    cash, price, wrappers needed, type

    14, 2, 6, 'milk'

Using the above order as an example, the shopper has $14. Each chocolate costs $2 so the shopper is able to buy 7
`milk` chocolates ($14/$2). The promotion states that the shopper will receive a complimentary `milk` chocolate for
every 6 wrappers traded in (because `wrappers needed` is 6 for this order). The shopper has 7 wrappers, so can trade in
6 wrappers and receives a complimentary `milk` chocolate. Additionally, the shopper is given a complimentary
`sugar free` chocolate. The shopper will end up with 8 `milk` chocolates and 1 `sugar free` chocolate.

In this example, the file `output/redemptions.csv` should contain the following:

#### output/redemptions.csv

    milk 8, dark 0, white 0, sugar free 1

