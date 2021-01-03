insert into docDocumentItem
	(
	[Quantity],
        [ProductID],
        [Description],
        [DiscountPerc],
        [UnitPrice],
        [Total],
        [CostPrice],
        [ProductKey],
        [DateItem],
        [Comments]
	)
select	{cCantidad},
        [ProductID],
        [Description],
        [DiscountPerc],
        [UnitPrice],
        [Total],
        [CostPrice],
        [ProductKey],
        [DateItem],
        '{cTitulo}'
from	docDocumentItem
where	DocumentItemID = {pItemID}