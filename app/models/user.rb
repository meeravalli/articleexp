class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :address, :photo, :phone_no, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :uid, :provider

  # attr_accessible :title, :body
  #  attr_accessible :name, :address, :photo, :phone_no, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at

# has_attached_file :photo, :styles => { :small => "150x150>" },
#   :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
#    :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
#   validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  has_attached_file :photo, :styles => { :medium => "200x250>", :thumb  => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\z/
 
  devise :omniauthable

   def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create( provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end    
     end
  end
  # def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
  # user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #       if user
  #         return user
  #       else
  #         registered_user = User.where(:email => auth.uid + "@twitter.com").first
  #         if registered_user
  #           return registered_user
  #         else

  #           user = User.create(provider:auth.provider,
  #                              uid:auth.uid,
  #                               email:auth.uid+"@twitter.com",
  #                               password:Devise.friendly_token[0,20],
  #                             )
  #         end

  #       end
  #   end
     
  #   def self.connect_to_linkedin(auth, signed_in_resource=nil)
  #       user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #       if user
  #         return user
  #       else
  #         registered_user = User.where(:email => auth.info.email).first
  #         if registered_user
  #           return registered_user
  #         else

  #           user = User.create(provider:auth.provider,
  #                               uid:auth.uid,
  #                               email:auth.info.email,
  #                               password:Devise.friendly_token[0,20],
  #                             )
  #         end

  #       end
  #   end
     
              
    def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
        if user
              return user
        else
             registered_user = User.where(:email => access_token.info.email).first
              if registered_user
                return registered_user
              else
               user = User.create(provider:access_token.provider,
                  email: data["email"],
                  uid: access_token.uid ,
                  password: Devise.friendly_token[0,20],
                )
            end
           end
    end
    

end
