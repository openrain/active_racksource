class DogsController < ApplicationController
  make_resourceful do
    actions :all
  end
end
