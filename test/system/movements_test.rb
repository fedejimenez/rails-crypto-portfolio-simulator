require "application_system_test_case"

class MovementsTest < ApplicationSystemTestCase
  setup do
    @movement = movements(:one)
  end

  test "visiting the index" do
    visit movements_url
    assert_selector "h1", text: "Movements"
  end

  test "creating a Movement" do
    visit movements_url
    click_on "New Movement"

    fill_in "Crypto", with: @movement.crypto_id
    fill_in "Date", with: @movement.date
    fill_in "Operation", with: @movement.operation
    fill_in "Price", with: @movement.price
    fill_in "Quantity", with: @movement.quantity
    click_on "Create Movement"

    assert_text "Movement was successfully created"
    click_on "Back"
  end

  test "updating a Movement" do
    visit movements_url
    click_on "Edit", match: :first

    fill_in "Crypto", with: @movement.crypto_id
    fill_in "Date", with: @movement.date
    fill_in "Operation", with: @movement.operation
    fill_in "Price", with: @movement.price
    fill_in "Quantity", with: @movement.quantity
    click_on "Update Movement"

    assert_text "Movement was successfully updated"
    click_on "Back"
  end

  test "destroying a Movement" do
    visit movements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movement was successfully destroyed"
  end
end
