describe Tickets::Represent do
  subject :result do
    described_class.call(json: json).value
  end

  let(:json) { file_fixture('ticket_with_excavator.json').read }

  context 'with valid JSON argument' do
    it 'returns ticket attributes' do
      expect(result[:attributes]).to eq(
        {
          additional_service_area_codes: %w[ZZL01 ZZL02 ZZL03],
          geo_polygon: '[[-81.13390268058475, 32.07206917625161], [-81.14660562247929, 32.04064386441295], [-81.08858407706913, 32.02259853170128], [-81.05322183341679, 32.02434500961698], [-81.05047525138554, 32.042681017283066], [-81.0319358226746, 32.06537765335268], [-81.01202310294804, 32.078469305179404], [-81.02850259513554, 32.07963291684719], [-81.07759774894413, 32.07090546831167], [-81.12154306144413, 32.08806865844325], [-81.13390268058475, 32.07206917625161]]',
          primary_service_area_code: 'ZZGL103',
          request_number: '09252012-00001',
          request_type: 'normal',
          response_due_at: Time.zone.local(2011, 7, 13, 23, 59, 59),
          sequence_number: '2421'
        }
      )
    end
  end

  context 'with argument containing non-JSON data' do
    let(:json) { 'not a JSON' }

    it 'returns error message' do
      is_expected.to eq('invalid JSON data')
    end
  end

  context 'with wrong JSON structure' do
    let(:json) { '{"some" : "json"}' }

    it 'returns attributes with empty values' do
      expect(result[:attributes]).to eq(
        {
          additional_service_area_codes: [],
          geo_polygon: nil,
          primary_service_area_code: nil,
          request_number: nil,
          request_type: nil,
          response_due_at: nil,
          sequence_number: nil
        }
      )
    end
  end
end
