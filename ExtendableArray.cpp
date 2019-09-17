#include "ExtendableArray.h"
#include <iostream>

ExtendableArray::ExtendableArray() 
	:size(2)
{
	arrayPointer = new int[size];
	for (int i = 0; i < size; i++) {
		arrayPointer[i] = 0;
	}
}

ExtendableArray::~ExtendableArray() {
	delete[] arrayPointer;
}

ExtendableArray::ExtendableArray(const ExtendableArray& other)
	:size(other.size)
{
	arrayPointer = new int[other.size];
	for (int i = 0; i < size; i++) {
		arrayPointer[i] = other.arrayPointer[i];
	}
}

ExtendableArray& ExtendableArray::operator=(const ExtendableArray& rhs)
{
	size = rhs.size;
	delete[] arrayPointer; //delete original array 
	arrayPointer = new int[size];
	for (int i = 0; i < size; i++) {
		arrayPointer[i] = rhs.arrayPointer[i];
	}

	return *this;
}

ElementRef ExtendableArray::operator[](int i)
{
	ElementRef ref(*this, i);
	return ref;
}



ElementRef::ElementRef(ExtendableArray& theArray, int i)
{
	intArrayRef = &theArray;
	index = i;
}

ElementRef::ElementRef(const ElementRef& other)
{
	index = other.index;
	intArrayRef = other.intArrayRef;
}

ElementRef::~ElementRef()
{
	//delete intArrayRef; NO
}

ElementRef& ElementRef::operator=(const ElementRef& rhs)
{

	if (index + 1 > intArrayRef->size)
	{
		int* arr = new int[index + 1];
		for (int i = 0; i < intArrayRef->size; i++) {
			arr[i] = int(intArrayRef->arrayPointer[i]);
		}
		for (int i = intArrayRef->size; i < index; i++) {
			arr[i] = 0;
		}

		arr[index] = rhs.intArrayRef->arrayPointer[rhs.index];
		intArrayRef->size = index + 1;

		intArrayRef->arrayPointer = arr;

		return *this;
	}
	else
	{
		intArrayRef->arrayPointer[index] = rhs.intArrayRef->arrayPointer[rhs.index];

		return *this;
	}
}

ElementRef& ElementRef::operator=(int val)
{

	if (index + 1 > intArrayRef->size)
	{
		
		int* arr = new int[index + 1];

		for (int i = 0; i < intArrayRef->size; i++) {
			arr[i] = intArrayRef->arrayPointer[i];
		}
		for (int i = intArrayRef->size; i < index; i++) {
			arr[i] = 0;
		}
		arr[index] = val;
		intArrayRef->size = index + 1;

		intArrayRef->arrayPointer = arr;


		return *this;
	}
	else
	{
		intArrayRef->arrayPointer[index] = val;

		return *this;
	}
}

ElementRef::operator int() const
{
	if (index < intArrayRef->size)
	{
		return intArrayRef->arrayPointer[index];
	}
	else {
		return 0;
	}	
}
