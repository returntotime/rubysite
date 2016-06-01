Spree.user_class.class_eval do


  def fullname
    self.firstname + ' ' +self.lastname
  end
end
