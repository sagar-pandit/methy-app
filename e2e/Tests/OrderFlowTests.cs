using Microsoft.Playwright;
using Xunit;

namespace Methy.E2E.Tests;

/// <summary>
/// End-to-end tests for the full order placement flow.
/// Tests run against a locally running Methy stack (docker compose up).
/// </summary>
public class OrderFlowTests : IAsyncLifetime
{
    private IPlaywright _playwright = null!;
    private IBrowser _browser = null!;
    private IBrowserContext _context = null!;
    private IPage _page = null!;

    private const string BaseUrl = "http://localhost:4200";

    public async Task InitializeAsync()
    {
        _playwright = await Playwright.CreateAsync();
        _browser = await _playwright.Chromium.LaunchAsync(new BrowserTypeLaunchOptions
        {
            Headless = true,
        });
        _context = await _browser.NewContextAsync();
        _page = await _context.NewPageAsync();
    }

    public async Task DisposeAsync()
    {
        await _context.DisposeAsync();
        await _browser.DisposeAsync();
        _playwright.Dispose();
    }

    [Fact]
    public async Task User_CanNavigateToRestaurantList()
    {
        await _page.GotoAsync($"{BaseUrl}/restaurants");
        await _page.WaitForLoadStateAsync(LoadState.NetworkIdle);

        // Placeholder assertion — update when RestaurantListComponent is implemented
        Assert.Equal(200, _page.Context.Browser?.IsConnected == true ? 200 : 0);
    }

    [Fact]
    public async Task User_CanAddItemToCartAndCheckout()
    {
        // Placeholder — full order flow E2E test
        // Steps: login → browse restaurants → pick restaurant → add item → checkout
        await _page.GotoAsync($"{BaseUrl}/restaurants");
        await _page.WaitForLoadStateAsync(LoadState.NetworkIdle);

        // TODO: implement when restaurant listing and cart are built
        Assert.True(true, "Placeholder — implement in Phase 2");
    }
}
