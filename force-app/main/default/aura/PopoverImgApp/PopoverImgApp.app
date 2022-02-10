<aura:application >
    <!-- I'm assuming you are adding your slds library here -->
    <div class="slds">
    <ul>
        <aura:iteration items="one,two,three" var="item">
            <c:PopoverImg popoverMessage="{!item + ' has been hovered over'}"/>
            <br/>
        </aura:iteration> 
    </ul>
    </div>
</aura:application>