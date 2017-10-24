require 'rails_helper'

describe MoviesController do
    
    describe "#create" do
        context "When a movie has been created" do
            it "should exist in Movies" do
                @movie_id = "1234"
                @movie = double('fake movie').as_null_object
                
                post :create, {movie: @movie.id, movie: {:title => 'Fake Movie', :release_date => 'Sep 1, 2011', :rating => 'G', :description => 'bad', :director => ''}}
                
                expect(Movie.where(:title => 'Fake Movie').count).to eq(1)
                #expect(response).to redirect_to(movie_path)
                expect(flash[:notice]).to be_present
            end
        end
    end
    
    describe "#destroy" do
        context "When a movie has been destroyed" do
            it "should not exist in Movies" do
                @movie_id = "1234"
                @movie = double('fake movie').as_null_object
                expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                
                get :destroy, :id => @movie_id
                expect(Movie.where(:title => "fake movie").count).to eq(0)
                expect(response).to redirect_to(movies_path)
                expect(flash[:notice]).to be_present
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