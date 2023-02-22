public class FakeStoreApiData {
    public static FakeStoreApiData.Item[] items;

    public class Item {
        public Integer id { get; set; } //1
        public String title { get; set; } //Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops
        public Double price { get; set; } //109.95
        public String description { get; set; } //Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday
        public String category { get; set; } //men's clothing
        public String image { get; set; } //https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg
        public Cls_Rating rating { get; set; }
    }

    private class Cls_Rating {
        public Double rate { get; set; } //3.9
        public Integer count { get; set; } //120
    }

    public static FakeStoreApiData parse(String json) {
        return (FakeStoreApiData) System.JSON.deserialize(json, FakeStoreApiData.class);
    }
}
