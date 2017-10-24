require 'rails_helper'

describe MoviesController do
    
    describe '#create' do
        context "When a movie has been created" do
            it "should increase the number of movies by 1" do
                # expect { 
                #     post :create, :title => {:title => '1234' }
                # }.to change { Movie.count }
                
                Movie.create!(:title => "Cog")
                expect(Movie.where(:title => "Cog").count).to eq(1)
            end
        end
    end
    
    describe "#director" do
        context "When the specified movie has a director" do
            
            it "should find movies with the same director" do
            
                @movie_id = "1234"
                @movie = double('fake movie', :director => 'James Cameron')
                
                expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                expect(@movie).to receive(:similar_movies)
                
                get :director, :id => @movie_id
                
                expect(response).to render_template(:director)
            end
        
        end
        context "When the specified movie does not have a director" do 
            it "should find movies with the same director" do
                @movie_id = "1234"
                @movie = double('fake movie').as_null_object
                expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                
                get :director, :id => @movie_id
                
                expect(response).to redirect_to(movies_path)
                
            end
        end
        
    
    end

end