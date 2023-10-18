<script lang="ts">
    export let onClick: () =>{};
    export let label: string;
    export let loading: boolean;
</script>

<button on:click={onClick} class="bg-[#378E8B] p-3 rounded-[4px] font-semibold mt-5 mb-3">
        {label}
</button>
