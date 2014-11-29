require 'spec_helper'

describe 'validations' do

  it 'validates presence of username' do
    bu = BlacklistUser.create
    expect(bu.valid?).to eq(false)
    expect(bu.errors[:username]).to eq(["can't be blank"])
  end

  it 'validates presence of user id' do
    bu = BlacklistUser.create
    expect(bu.valid?).to eq(false)
    expect(bu.errors[:user_id]).to eq(["can't be blank"])
  end

  it 'validates uniquness of username with user id' do
    bu_1 = BlacklistUser.create(username: "someone", user_id: 1)
    expect(bu_1.valid?).to eq(true)

    bu_2 = BlacklistUser.create(username: "someone", user_id: 2)
    expect(bu_2.valid?).to eq(true)

    bu_3 = BlacklistUser.create(username: "someone", user_id: 1)
    expect(bu_3.valid?).to eq(false)
    expect(bu_3.errors[:username]).to eq(["has already been taken"])
  end

  it 'creates successfully' do
    bu = BlacklistUser.create(username: "someone", user_id: 1)    
    expect(bu.valid?).to eq(true)
  end


end