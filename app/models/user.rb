class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  

  def cart_count
  	$redis.scard "cart#{id}"
  end

  has_many :purchases, foreign_key: :buyer_id
  has_many :movies, through: :purchases   

  def cart_total_price
  	total_price = 0
  	get_cart_movies.each { |movie| total_price+= movie.price }
  	total_price
  end
 
  def get_cart_movies
  	cart_ids = $redis.smembers "cart#{id}"
  	Movie.find(cart_ids)
  end

  def purchase_cart_movies!
  	get_cart_movies.each { |movie| purchase(movie) }
  	$redis.del "cart#{id}"
  end
 
  def purchase(movie)
  	movies << movie unless purchase?(movie)
  end
 
  def purchase?(movie)
  	movies.include?(movie)
  end

  def has_payment_info?
    braintree_customer_id
  end    
end
