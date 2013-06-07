require 'active_record'


class DataBaseActiveRecordExample
	def getting_Connection 
		#---------------- getting connection to the Mysql database ------------------
		ActiveRecord::Base.establish_connection(
			:adapter => "mysql",
			:host => "localhost",
			:username => "root",
			:password => "root",
			:database  => "rubyexample"
		)
		#------------------- Setting table name and class name as same
		ActiveRecord::Base.pluralize_table_names = false
		select_Operation # method to call Operation Selection
	end

	def select_Operation
		print "1. Select Records \n"
		print "2. Insert Records \n"
		print "3. Update Records \n"
		print "4. Delete Records \n"
		print "Enter your option"
		op = gets.chomp.to_i;	
		case op
			when 1
				retrieving_Records
			when 2
				inserting_Records
			when 3
				updating_Records
			when 4
				deleting_Records
			else
				puts "Invalid Option"
		end
	end
	
	#------------------ Inseting Data to the products table of Mysql ---------------
	class Products < ActiveRecord::Base
	end
	def inserting_Records 
		print "Enter Product Id: \n"
		pno = gets.chomp.to_i;
		print "Enter Product Name: \n"
		pname = gets.chomp;
		print "Enter Product Cost: \n"
		pcost = gets.chomp.to_i;
		print "Enter Product Quantity: \n"
		pqty = gets.chomp.to_i;

		begin
			@pro = Products.new #Object created for a class Products

			@pro.pro_id = pno
			@pro.pro_name = pname
			@pro.pro_cost = pcost
			@pro.pro_quantity = pqty
			@pro.save
			puts "Record Inserted....."
		rescue 
			puts "Problem occur while inserting data into table"
		end
	end

		#------------------------- Selecting Records -----------------------------
	def retrieving_Records
			#------------ Code for gathering column names dynamically ------------
		cclist = Array.new 
		clist = ActiveRecord::Base.connection.execute("DESCRIBE products")
		clist.each{|c|  cclist << c[0].to_s }.to_a

			#------------------ Displaying table in a Tabular Format --------------
		print "+--------------------------------------------------------------+ \n"
		print "|#{cclist[0]}\t|      #{cclist[1]} \t|  #{cclist[2]}     |#{cclist[3]}  |\n"
		print "+--------------------------------------------------------------+ \n"
		Products.all.each do |pro|
		  printf "|%5d  |%15s\t| %10d\t| %5d        |\n", pro.pro_id, pro.pro_name,pro.pro_cost, pro.pro_quantity
		end
		print "+--------------------------------------------------------------+ \n"
	end
	
		#------------------- Code for Upate Records --------------------
	def updating_Records
		print "Enter Product Number to Update Quantities \n"
		pno = gets.chomp.to_i
		print "Enter Quantities to Update: \n"
		pqty = gets.chomp.to_i
			begin
				Products.update(pno,"pro_quantity"=>pqty)
				puts "Records Updated"
			rescue
				puts "Problem Occur while Updating the table"
			end
	end
	

		#----------------------- Code for deleting Records -----------------------
	def deleting_Records
		print "Do you want to delete all records or Particular Records \n"
		print "1. All Records \n"
		print "2. Particular Records \n"
		print "Enter your option: \n"
		op1 = gets.chomp.to_i
			case op1
				when 1
					begin
						count = Products.delete_all()
						puts "#{count} Records Deleted Succesfully ...."
					rescue
						puts "Problem occur while deleting the records"
					end
				when 2
					begin
						print "Enter Which record do you want to delete"
						par = gets.chomp.to_i
						count = Products.delete(par)
						puts "#{count}   Record Deleted...."
					rescue
						puts "Problem Occur while deleting record"
					end
				else
					puts "Invalid Option"
			end
	end
end

	dbar = DataBaseActiveRecordExample.new
	dbar.getting_Connection
