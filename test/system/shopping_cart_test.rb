require "application_system_test_case"

class ShoppingCartTest < ApplicationSystemTestCase
  setup do
    @shopping_cart = shopping_cart(:one)
  end

  test "visiting the index" do
    visit shopping_cart_url
    assert_selector "h1", text: "Shopping Cart"
  end

  test "creating a Shopping cart" do
    visit shopping_cart_url
    click_on "New Shopping Cart"

    click_on "Create Shopping cart"

    assert_text "Shopping cart was successfully created"
    click_on "Back"
  end

  test "updating a Shopping cart" do
    visit shopping_cart_url
    click_on "Edit", match: :first

    click_on "Update Shopping cart"

    assert_text "Shopping cart was successfully updated"
    click_on "Back"
  end

  test "destroying a Shopping cart" do
    visit shopping_cart_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shopping cart was successfully destroyed"
  end
end
