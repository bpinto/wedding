require 'spec_helper'

describe GuestsController do
  let(:guest) { stub_model(Guest) }

  describe 'new' do
    before { Guest.stub(new: guest) }

    it 'assigns a guest' do
      get :new
      expect(assigns :guest).to eq guest
    end
  end

  describe 'create' do
    before { Guest.stub(new: guest) }

    let(:params)  { { guest: { name: :any } } }

    context 'successfully' do
      before { guest.stub(save: true) }

      it 'redirects to the root page' do
        post :create, params
        expect(response).to redirect_to root_path
      end

      it 'saves the guest' do
        expect(guest).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { guest.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end
    end
  end
end
