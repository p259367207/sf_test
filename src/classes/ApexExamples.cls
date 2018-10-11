public class ApexExamples {

    public static List<DishIngredientAssociation__c> getDishesWithIngredients() {
        List<Dish__c> dishes = [
            SELECT Id, Name,
			(
				SELECT Id, Ingredient__r.Name
				FROM DishIngredientAssociations__r
			) 
			FROM Dish__c
        ];
		return dishes.get(0).DishIngredientAssociations__r;
	}
}