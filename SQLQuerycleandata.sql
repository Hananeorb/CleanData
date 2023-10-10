

Select*
From [PortfolioProject ].dbo.Nashvillehousing



Select SaleDateConverted,Convert(Date,saleDate)
From [PortfolioProject ].dbo.Nashvillehousing

Update Nashvillehousing
SET SaleDate=Convert(Date,saleDate)

Alter table Nashvillehousing
Add SaleDateConverted Date;
Update Nashvillehousing
SET SaleDateConverted=Convert(Date,saleDate)



Select *
From [PortfolioProject ].dbo.Nashvillehousing
--Where PropertyAddress is null
order by ParcelID


Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
From [PortfolioProject ].dbo.Nashvillehousing a
Join [PortfolioProject ].dbo.Nashvillehousing b
On b.ParcelID=b.ParcelID
And a.[UniqueID ]<>b.[UniqueID ]


Update a
Set PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
From [PortfolioProject ].dbo.Nashvillehousing a
Join [PortfolioProject ].dbo.Nashvillehousing b
On b.ParcelID=b.ParcelID
And a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null


Select PropertyAddress
From [PortfolioProject ].dbo.Nashvillehousing

Select 
SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,SUBSTRING (PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) as Address
From PortfolioProject.dbo.Nashvillehousing


Alter table Nashvillehousing
Add PropertySplitAddress Nvarchar(255);


Update Nashvillehousing
SET PropertySplitAddress=SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

Alter table Nashvillehousing
Add PropertySplitCity Nvarchar(255);


Update Nashvillehousing
SET PropertySplitCity=SUBSTRING (PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))


Select*
FROM  Nashvillehousing


Select OwnerAddress
FROM  Nashvillehousing

Select OwnerAddress,
PARSENAME(REPLACE (OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From Nashvillehousing

Alter table Nashvillehousing
Add OwnerSplitAddress Nvarchar(255);


Update Nashvillehousing
SET OwnerSplitAddress=PARSENAME(REPLACE (OwnerAddress,',','.'),3)

Alter table Nashvillehousing
Add OwnerSplitCity Nvarchar(255);


Update Nashvillehousing
SET OwnerSplitCity=PARSENAME(REPLACE (OwnerAddress,',','.'),2)

Alter table Nashvillehousing
Add OwnerSplitState Nvarchar(255);


Update Nashvillehousing
SET OwnerSplitState=PARSENAME(REPLACE (OwnerAddress,',','.'),1)


Select *
From Nashvillehousing


Select distinct (SoldAsVacant),Count(SoldAsVacant)
FROM Nashvillehousing
Group by SoldAsVacant
Order by 2


Select SoldAsVacant
,Case When SoldAsVacant='Y' Then 'Yes'
      When SoldAsVacant='N' Then 'Yes'
	  Else SoldAsVacant
	  END
From Nashvillehousing


Update Nashvillehousing
SET SoldAsVacant=Case When SoldAsVacant='Y' Then 'Yes'
      When SoldAsVacant='N' Then 'Yes'
	  Else SoldAsVacant
	  END

With RowNumCTE AS (
Select*,
	  ROW_NUMBER()OVER (
	  PARTITION BY ParcelID,
	  PropertyAddress,
	  SalePrice,
	  SaleDate,
	  LegalReference
	  Order by 
	  UniqueID
	  ) row_num
	  From Nashvillehousing
	  --Order by ParcelID
	  )

	  Select*
	  From RowNumCTE
	  Where row_num>1
	  --Order by PropertyAddress


	  Select*
	  From Nashvillehousing

 Alter table  Nashvillehousing
 Drop COLUMN OwnerAddress,TaxDistrict,PropertyAddress

Alter table  Nashvillehousing
Drop COLUMN SaleDate