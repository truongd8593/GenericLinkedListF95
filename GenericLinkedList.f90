!  GenericLinkedList.f90
!
!  FUNCTIONS:
!	GenericLinkedList      - Entry point of console application.
!
!	Example of generic linked list in Fortran 95.
!

!****************************************************************************
!
!  PROGRAM: GenericLinkedList
!
!  PURPOSE:  generic linked list in Fortran 95.
!
!****************************************************************************

	program GenericLinkedList

	use mod_generic_list
    use mod_data

    implicit none

    type(list_node_t), pointer :: list => null()
	type(list_node_t), pointer :: list_tranverser => null()
	type(list_node_t), pointer :: elem => null()
    type(data_int_ptr)         :: ptr

    integer :: i, k



    do i = 1, 5
		ptr = data_int_ptr_constructor(i);

        if (.not.associated(list)) then
			call list_init(list,transfer(ptr,list_data))
        else
            call list_insert(list,transfer(ptr,list_data))
        endif
    enddo


    print*,'********************************************'
    print*,'Linked list:'
    call data_int_ptr_print(list)

    ! Remove node which has data = 3 in the list
    list_tranverser => list

    do while (associated(list_tranverser))
        ptr = transfer(list_get(list_tranverser), ptr)
        k = ptr%p%n

        if (k == 3) then
			elem => list_tranverser
			call list_remove_node(list_tranverser)
		endif

        list_tranverser => list_next(list_tranverser)
    end do

    ! Print the list again
    print*,'********************************************'
    print*,'Linked list after remove node has value = 3:'
    call data_int_ptr_print(list)

    ! Free the list
    call list_free(list)

	end program GenericLinkedList

