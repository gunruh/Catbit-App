class PostsController < ApplicationController

   def index
      @posts = Post.all
   end

   def show
      @post = Post.find(params[:id])
   end

   def new
      @post = Post.new
   end

   def edit
      @post = Post.find(params[:id])
   end

   def create
      @post = Post.new(post_params)

      if @post.save
         set_hashtags(@post)
         redirect_to @post
      else 
         render 'new'
      end
   end

   def update
      @post = Post.find(params[:id])
    
      if @post.update(post_params)
         set_hashtags(@post)
         redirect_to @post
      else
         render 'edit'
      end
   end

   def destroy
      @post = Post.find(params[:id])
      old_hashtags = @post.hashtags.to_a
      @post.destroy

      check_hashtags_for_deletion(old_hashtags)
      redirect_to posts_path
   end

   private
      def post_params
         params.require(:post).permit(:content)
      end

      def set_hashtags(post)
         old_hashtags = post.hashtags.to_a
         post.hashtags.clear
         # post.hashtags.each do |hashtag|

         hashtags = hashtags_in_str(post.content)
         hashtags.each do |hashtag_str|
            hashtag = Hashtag.where(["text = :t", { t: hashtag_str }]).first
            if hashtag.nil?
               post.hashtags << Hashtag.new(text: hashtag_str)
            else
               post.hashtags << hashtag
            end
         end

         # Check if any of the old hashtags no longer have a post.
         check_hashtags_for_deletion(old_hashtags)
      end

      def hashtags_in_str(content)
         content.scan(/#\w+/)
      end

      def check_hashtags_for_deletion(hashtags)
         hashtags.each do |hashtag|
            posts = hashtag.posts(false)
            if posts.empty?
               hashtag.destroy
            else
               # Double check hashtags.
               posts.each do |post|
                  hashtag_str = hashtags_in_str(post.content)
                  found = false
                  hashtag_str.each do |hashtag_str|
                     if hashtag.text == hashtag_str
                        found = true
                        break
                     end
                  end
                  hashtag.destroy unless found
               end
            end
         end
      end
end
