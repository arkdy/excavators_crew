describe Excavators::Represent do
  subject :result do
    described_class.call(json: json).value
  end

  let(:json) do
    '{
      "Excavator":{
         "CompanyName":"John Doe CONSTRUCTION",
         "Address":"555 Some RD",
         "City":"SOME PARK",
         "State":"ZZ",
         "Zip":"55555",
         "Type":"Excavator",
         "Contact":{
            "Name":"Johnny Doe",
            "Phone":"1115552345",
            "Email":"example@example.com"
         },
         "FieldContact":{
            "Name":"Field Contact",
            "Phone":"1235557924",
            "Email":"example@example.com"
         },
         "CrewOnsite":"true"
      }
    }'
  end

  context 'with valid JSON argument' do
    it 'returns excavator attributes' do
      expect(result[:attributes]).to eq(
        {
          address: '555 Some RD, SOME PARK, ZZ, 55555',
          company_name: 'John Doe CONSTRUCTION',
          crew_onsite: true
        }
      )
    end
  end

  context 'with argument containing non-JSON data' do
    let(:json) { 'not a JSON' }

    it 'returns error message' do
      expect(result).to eq('invalid JSON data')
    end
  end

  context 'with wrong JSON structure' do
    let(:json) { '{"some" : "json"}' }

    it 'returns attributes with empty values' do
      expect(result[:attributes]).to eq(
        {
          address: nil,
          company_name: nil,
          crew_onsite: false
        }
      )
    end
  end
end
