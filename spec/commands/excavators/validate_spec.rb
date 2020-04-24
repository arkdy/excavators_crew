describe Excavators::Validate do
  subject(:result) do
    described_class.call(attributes: excavator_attributes).value
  end

  let(:excavator_attributes) do
    {
      address: '555 Some RD, SOME PARK, ZZ, 55555',
      company_name: 'John Doe CONSTRUCTION',
      crew_onsite: true
    }
  end

  context 'with all correct attributes' do
    it 'returns same attributes' do
      expect(result[:attributes]).to eq(excavator_attributes)
    end
  end

  context 'when some attributes are empty or missing' do
    context 'with :company_name' do
      context "when it's missing" do
        let(:excavator_attributes) { super().without(:company_name) }

        it { is_expected.to eq({ company_name: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:excavator_attributes) { super().tap { |h| h[:company_name] = nil } }

        it { is_expected.to eq({ company_name: ['must be a string'] }) }
      end
    end

    context 'with :address' do
      context "when it's missing" do
        let(:excavator_attributes) { super().without(:address) }

        it { is_expected.to eq({ address: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:excavator_attributes) { super().tap { |h| h[:address] = nil } }

        it { is_expected.to eq({ address: ['must be a string'] }) }
      end
    end

    context 'with :crew_onsite' do
      context "when it's missing" do
        let(:excavator_attributes) { super().without(:crew_onsite) }

        it { is_expected.to eq({ crew_onsite: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:excavator_attributes) { super().tap { |h| h[:crew_onsite] = nil } }

        it { is_expected.to eq({ crew_onsite: ['must be boolean'] }) }
      end
    end
  end
end
