describe "Tickets management", type: :system do
  before do
    driven_by :selenium_chrome_headless
  end

  before :all do
    Ticket.create(request_number: 'request-number-column', geo_polygon: '[[-81.13390268058475, 32.07206917625161], [-81.14660562247929, 32.04064386441295], [-81.08858407706913, 32.02259853170128], [-81.05322183341679, 32.02434500961698], [-81.05047525138554, 32.042681017283066], [-81.0319358226746, 32.06537765335268], [-81.01202310294804, 32.078469305179404], [-81.02850259513554, 32.07963291684719], [-81.07759774894413, 32.07090546831167], [-81.12154306144413, 32.08806865844325], [-81.13390268058475, 32.07206917625161]]')
  end

  it "shows me the list of tickets" do
    visit "/tickets"

    expect(page).to have_text("Tickets")
    expect(page).to have_text("request-number-column")
  end

  it "shows ticket details page with polygon area displayed over the map" do
    visit "/tickets/#{Ticket.last.id}"

    expect(page).to have_text("Ticket #{Ticket.last.id}")
    expect(page).to have_css("path.leaflet-interactive")
  end

end
