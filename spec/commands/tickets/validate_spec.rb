describe Tickets::Validate do
  subject :result do
    described_class.call(attributes: ticket_attributes).value
  end

  let(:ticket_attributes) do
    {
      additional_service_area_codes: %w[ZZL01 ZZL02 ZZL03],
      geo_polygon: '-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295',
      primary_service_area_code: 'ZZGL103',
      request_number: '09252012-00001',
      request_type: 'normal',
      response_due_at: Time.zone.local(2020, 7, 13, 23, 59, 59),
      sequence_number: '2421'
    }
  end

  context 'with all correct attributes' do
    it 'returns same attributes' do
      expect(result[:attributes]).to eq(ticket_attributes)
    end
  end

  context 'when some attributes are empty or missing' do
    context 'with :additional_service_area_codes' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:additional_service_area_codes) }

        it { is_expected.to eq({ additional_service_area_codes: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:additional_service_area_codes] = nil } }

        it { is_expected.to eq({ additional_service_area_codes: ['must be an array'] }) }
      end
    end

    context 'with :geo_polygon' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:geo_polygon) }

        it { is_expected.to eq({ geo_polygon: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:geo_polygon] = nil } }

        it { is_expected.to eq({ geo_polygon: ['must be a string'] }) }
      end
    end

    context 'with :primary_service_area_code' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:primary_service_area_code) }

        it { is_expected.to eq({ primary_service_area_code: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:primary_service_area_code] = nil } }

        it { is_expected.to eq({ primary_service_area_code: ['must be a string'] }) }
      end
    end

    context 'with :request_number' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:request_number) }

        it { is_expected.to eq({ request_number: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:request_number] = nil } }

        it { is_expected.to eq({ request_number: ['must be a string'] }) }
      end
    end

    context 'with :request_type' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:request_type) }

        it { is_expected.to eq({ request_type: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:request_type] = nil } }

        it { is_expected.to eq({ request_type: ['must be a string'] }) }
      end
    end

    context 'with :response_due_at' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:response_due_at) }

        it { is_expected.to eq({ response_due_at: ['is missing'] }) }
      end

      context "when it's incorrect" do
        let(:ticket_attributes) { super().tap { |h| h[:response_due_at] = 'just a string' } }

        it { is_expected.to eq({ response_due_at: ['must be a time'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:response_due_at] = nil } }

        it { is_expected.to eq({ response_due_at: ['must be a time'] }) }
      end
    end

    context 'with :sequence_number' do
      context "when it's missing" do
        let(:ticket_attributes) { super().without(:sequence_number) }

        it { is_expected.to eq({ sequence_number: ['is missing'] }) }
      end

      context "when it's empty" do
        let(:ticket_attributes) { super().tap { |h| h[:sequence_number] = nil } }

        it { is_expected.to eq({ sequence_number: ['must be a string'] }) }
      end
    end
  end
end
